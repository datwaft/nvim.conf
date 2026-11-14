---@param name string
---@return string
local function get_grammar_revision(name)
  local plugin = assert(require("lazy.core.config").plugins[name], "Unknown grammar plugin: " .. name)
  local info = assert(require("lazy.manage.git").info(plugin.dir), "Missing grammar checkout: " .. name)
  local revision = assert(info.commit, "Missing grammar commit: " .. name)
  require("nvim-treesitter.log").trace("%s checkout revision: %s", name, revision)
  return revision
end

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    dependencies = {
      { "bezhermoso/tree-sitter-ghostty", build = "make nvim_install" },
      { "datwaft/tree-sitter-docstring" },
      { "datwaft/tree-sitter-bg3" },
      { "rmuir/tree-sitter-ghactions", build = false },
      { "Freed-Wu/tree-sitter-tmux", branch = "main", build = false },
      { "datwaft/tree-sitter-lua", build = false },
      { "OXY2DEV/tree-sitter-comment", build = false },
    },
    init = function()
      vim.treesitter.language.register("bash", "sh")
      vim.treesitter.language.register("fennel", "fnl")
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("tree-sitter-enable", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang or not vim.treesitter.language.add(lang) then return end
          if vim.treesitter.query.get(lang, "highlights") then vim.treesitter.start(args.buf) end
          if vim.treesitter.query.get(lang, "indents") then
            vim.bo.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
          end
          if vim.treesitter.query.get(lang, "folds") then
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = vim.treesitter.foldexpr
          end
        end,
      })
    end,
    config = function()
      -- Custom parsers
      vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("tree-sitter-custom-parsers", { clear = true }),
        pattern = "TSUpdate",
        callback = function()
          local parsers = require("nvim-treesitter.parsers")
          parsers.bg3_stats = {
            tier = 1,
            install_info = {
              url = "https://github.com/datwaft/tree-sitter-bg3",
              revision = get_grammar_revision("tree-sitter-bg3"),
              location = "tree-sitter-bg3-stats",
              queries = "tree-sitter-bg3-stats/queries",
            },
          }
          parsers.bg3_stats_value = {
            tier = 1,
            install_info = {
              url = "https://github.com/datwaft/tree-sitter-bg3",
              revision = get_grammar_revision("tree-sitter-bg3"),
              location = "tree-sitter-bg3-stats-value",
              queries = "tree-sitter-bg3-stats-value/queries",
            },
          }
          parsers.bg3_thoth = {
            tier = 1,
            install_info = {
              url = "https://github.com/datwaft/tree-sitter-bg3",
              revision = get_grammar_revision("tree-sitter-bg3"),
              location = "tree-sitter-bg3-thoth",
              queries = "tree-sitter-bg3-thoth/queries",
            },
          }
          parsers.bg3_osiris = {
            tier = 1,
            install_info = {
              url = "https://github.com/datwaft/tree-sitter-bg3",
              revision = get_grammar_revision("tree-sitter-bg3"),
              location = "tree-sitter-bg3-osiris",
              queries = "tree-sitter-bg3-osiris/queries",
            },
          }
          parsers.ghostty = {
            tier = 1,
            install_info = {
              url = "https://github.com/bezhermoso/tree-sitter-ghostty",
              revision = get_grammar_revision("tree-sitter-ghostty"),
              generate = true,
              queries = "queries/ghostty",
            },
          }
          parsers.docstring = {
            tier = 1,
            install_info = {
              url = "https://github.com/datwaft/tree-sitter-docstring",
              revision = get_grammar_revision("tree-sitter-docstring"),
              queries = "queries",
            },
          }
          parsers.ghactions = {
            tier = 1,
            install_info = {
              url = "https://github.com/rmuir/tree-sitter-ghactions",
              revision = get_grammar_revision("tree-sitter-ghactions"),
              queries = "queries",
            },
          }
          parsers.tmux = {
            tier = 1,
            install_info = {
              url = "https://github.com/Freed-Wu/tree-sitter-tmux",
              revision = get_grammar_revision("tree-sitter-tmux"),
              queries = "queries",
            },
          }
          parsers.lua.install_info = {
            url = "https://github.com/datwaft/tree-sitter-lua",
            revision = get_grammar_revision("tree-sitter-lua"),
            queries = "queries",
          }
          parsers.comment.install_info = {
            url = "https://github.com/OXY2DEV/tree-sitter-comment",
            revision = get_grammar_revision("tree-sitter-comment"),
            queries = "queries",
          }
        end,
      })

      -- `:TSUninstall` skips languages nvim-treesitter no longer lists, so remove their files directly
      vim.api.nvim_create_user_command("TSCleanup", function()
        local ts_config = require("nvim-treesitter.config")
        local log = require("nvim-treesitter.log")
        local available = ts_config.get_available()
        local entry_patterns = {
          parser = "^(.+)%.so$",
          ["parser-info"] = "^(.+)%.revision$",
          queries = "^(.+)$",
        }

        local dropped = {} ---@type table<string, string[]>
        for dir, pattern in pairs(entry_patterns) do
          local install_dir = ts_config.get_install_dir(dir)
          for name in vim.fs.dir(install_dir) do
            local path = vim.fs.joinpath(install_dir, name)
            local lang = assert(name:match(pattern), "Unexpected tree-sitter install entry: " .. path)
            if not vim.list_contains(available, lang) then
              dropped[lang] = dropped[lang] or {}
              table.insert(dropped[lang], path)
            end
          end
        end

        local langs = vim.tbl_keys(dropped)
        if #langs == 0 then
          log.info("No dropped languages to clean up")
          return
        end
        table.sort(langs)
        for _, lang in ipairs(langs) do
          for _, path in ipairs(dropped[lang]) do
            vim.fs.rm(path, { recursive = true })
          end
        end
        log.info("Removed dropped languages: %s", table.concat(langs, ", "))
      end, { desc = "Remove installed tree-sitter languages that nvim-treesitter no longer supports" })

      -- Update parsers when updating plugins
      local syncing = false -- Support for `:Lazy sync`
      vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("tree-sitter-lazy-update", { clear = true }),
        pattern = { "LazySyncPre", "LazySync", "LazyInstall", "LazyUpdate", "LazyRestore" },
        callback = function(args)
          if args.match == "LazySyncPre" then
            syncing = true
            return
          end
          if syncing and args.match ~= "LazySync" then return end
          syncing = false
          -- Finish Lazy's callbacks before reading grammar revisions and starting builds.
          vim.schedule(function()
            require("nvim-treesitter.log").trace("Updating parsers after %s", args.match)
            local task = require("nvim-treesitter").update(nil, { summary = true })
            task:await(function(err, success)
              if err then error(task:traceback(err), 0) end
              assert(success, "Tree-sitter update failed; see :TSLog")
            end)
          end)
        end,
      })
    end,
  },
}
