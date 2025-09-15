---@type LazySpec
return {
  -- TMUX integration
  {
    "mrjones2014/smart-splits.nvim",
    version = ">=1.0.0",
    config = true,
    lazy = false,
    keys = function()
      local ss = require("smart-splits")
      return {
        -- <C-w>+hjkl
        { "<C-w>h", ss.move_cursor_left },
        { "<C-w>j", ss.move_cursor_down },
        { "<C-w>k", ss.move_cursor_up },
        { "<C-w>l", ss.move_cursor_right },
        -- OPT+hjkl
        { "<M-h>", ss.move_cursor_left },
        { "<M-j>", ss.move_cursor_down },
        { "<M-k>", ss.move_cursor_up },
        { "<M-l>", ss.move_cursor_right },
        -- OPT+HJKL
        { "<M-H>", ss.move_cursor_left },
        { "<M-J>", ss.move_cursor_down },
        { "<M-K>", ss.move_cursor_up },
        { "<M-L>", ss.move_cursor_right },
        -- OPT+SHIFT+ARROW
        { "<M-S-Left>", ss.move_cursor_left },
        { "<M-S-Down>", ss.move_cursor_down },
        { "<M-S-Up>", ss.move_cursor_up },
        { "<M-S-Right>", ss.move_cursor_right },
      }
    end,
  },
  -- Database
  {
    "kristijanhusak/vim-dadbod-ui",
    lazy = false,
    dependencies = {
      { "tpope/vim-dadbod" },
      { "kristijanhusak/vim-dadbod-completion" },
      { "tpope/vim-dotenv" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_use_nvim_notify = 1
    end,
    keys = {
      { "<C-w>q", "<cmd>DBUIToggle<cr>" },
    },
  },
  -- Jupyter Kernel
  {
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_wrap_output = true

      vim.keymap.set("x", "<localleader>e", ":<C-u>MoltenEvaluateVisual<cr>", { silent = true })
      vim.keymap.set("n", "<C-w>o", "<cmd>noautocmd MoltenEnterOutput<cr>", { silent = true })
      vim.keymap.set("n", "<C-w>O", "<cmd>MoltenHideOutput<cr>", { silent = true })
      vim.keymap.set("n", "<localleader>E", "<cmd>MoltenEvaluateOperator<cr>", { silent = true })
      vim.keymap.set("n", "<localleader>er", "<cmd>MoltenReevaluateCell<cr>", { silent = true })

      vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter" }, {
        group = vim.api.nvim_create_augroup("molten-nvim-import-chunks", { clear = true }),
        pattern = { "*.ipynb" },
        callback = function(args)
          if (args.event == "BufEnter" and vim.v.vim_did_enter ~= 1) or args.event == "BufAdd" then
            vim.schedule(function()
              ---@type string[]
              local kernels = vim.fn.MoltenAvailableKernels()

              ---@param path string
              ---@return string
              local function read_file(path)
                local fd = assert(vim.uv.fs_open(path, "r", 438))
                local stat = assert(vim.uv.fs_fstat(fd))
                local data = assert(vim.uv.fs_read(fd, stat.size, 0))
                assert(vim.uv.fs_close(fd))
                return data
              end

              local function try_kernel_name()
                local metadata = vim.json.decode(read_file(args.file))["metadata"]
                return metadata.kernelspec.name
              end

              ---@type boolean, string?
              local ok, kernel_name = pcall(try_kernel_name)
              if not ok or not vim.tbl_contains(kernels, kernel_name) then
                kernel_name = nil
                local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
                if venv ~= nil then kernel_name = string.match(venv, "/.+/(.+)") end
              end

              if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then vim.cmd.MoltenInit(kernel_name) end
              vim.cmd.MoltenImportOutput()
            end)
          end
        end,
      })

      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("molten-nvim-export-chunks", { clear = true }),
        pattern = { "*.ipynb" },
        callback = function()
          if require("molten.status").initialized() == "Molten" then vim.cmd.MoltenExportOutput({ bang = true }) end
        end,
      })
    end,
    dependencies = {
      {
        "3rd/image.nvim",
        opts = {
          backend = "kitty",
          max_width = 100,
          max_height = 12,
          max_height_window_percentage = math.huge,
          max_width_window_percentage = math.huge,
          window_overlap_clear_enabled = true,
        },
      },
    },
  },
}
