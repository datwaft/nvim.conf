local M = require("lualine.component"):extend()
const modules = require("lualine_require").lazy_require({
  jj_branch = "lualine.components.jj-vcs.jj_branch",
  utils = "lualine.utils.utils",
})

M.init = function(self, options)
  M.super.init(self, options)
  if not self.options.icon then
    self.options.icon = "" -- e0a0
  end
  modules.jj_branch.init()
end

M.update_status = function(_, is_focused)
  local buf = not is_focused ? vim.api.nvim_get_current_buf() : nil
  local branch = modules.jj_branch.get_branch(buf)
  return modules.utils.stl_escape(branch)
end

return M
