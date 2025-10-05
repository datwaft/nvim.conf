---@type LazySpec
return {
  {
    "jpalardy/vim-slime",
    event = "VeryLazy",
    init = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = {
        socket_name = vim.fn.split(vim.env.TMUX, ",")[1],
        target_pane = "{last}",
      }
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("vim-slime-keybinds", { clear = true }),
        callback = function()
          if vim.bo.buftype ~= "nofile" then
            vim.keymap.set("x", "<C-s>", "<Plug>SlimeRegionSend", { buffer = true })
            vim.keymap.set("n", "<C-s>", "<Plug>SlimeMotionSend", { buffer = true })
            vim.keymap.set("n", "<C-s>s", "<Plug>SlimeLineSend", { buffer = true })
            vim.keymap.set("n", "<C-s><C-s>", "<Plug>SlimeLineSend", { buffer = true })
            vim.keymap.set("n", "<C-s>c", "<Plug>SlimeConfig", { buffer = true })
          end
        end,
      })
    end,
  },
}
