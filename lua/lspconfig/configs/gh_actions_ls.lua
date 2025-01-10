return {
  default_config = {
    cmd = {
      "gh-actions-language-server",
      "--stdio",
    },
    filetypes = {
      "yaml",
    },
    single_file_support = true,
    root_dir = function(fname)
      if fname:match(".github/workflows") then
        return vim.fn.getcwd()
      end
    end,
  },
}
