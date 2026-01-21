local M = {}

local require = require("lualine_require").require
local utils = require("lualine.utils.utils")

-- vars
local current_jj_branch = ""
local current_jj_workspace = ""
local branch_cache = {} -- stores last known branch for a buffer
local workspace_cache = {} -- stores jj workspace root for directories
local active_bufnr = "0"
-- os specific path separator
local sep = package.config:sub(1, 1)
-- event watcher to watch head file
-- Use file watch for non Windows and poll for Windows.
-- Windows doesn't like file watch for some reason.
local file_changed = assert(sep ~= "\\" and vim.uv.new_fs_event() or vim.uv.new_fs_poll())
-- check if jj executable is available
local jj_available = vim.fn.executable("jj") == 1

-- Revset to find closest ancestor bookmark (fallback to trunk)
local closest_bookmark_revset = "heads(::@ & bookmarks()) | trunk()"

---Get jj branch info using revsets
---@param workspace string jj workspace root path
---@return string branch display string
local function get_jj_head(workspace)
  -- Get closest bookmark name
  local bookmark_result = vim.fn.systemlist({
    "jj",
    "log",
    "--repository",
    workspace,
    "--ignore-working-copy",
    "--no-graph",
    "--limit",
    "1",
    "-r",
    closest_bookmark_revset,
    "-T",
    "coalesce(bookmarks.join(','), change_id.shortest(4))",
  })

  if vim.v.shell_error ~= 0 then return "" end

  local anchor = vim.trim(bookmark_result[1] or "")
  if anchor == "" then return "" end

  -- Take first bookmark if multiple
  anchor = vim.split(anchor, ",", { plain = true })[1]

  -- Count commits between bookmark and @ for distance
  local distance_result = vim.fn.systemlist({
    "jj",
    "log",
    "--repository",
    workspace,
    "--ignore-working-copy",
    "--no-graph",
    "-r",
    "(" .. closest_bookmark_revset .. ")..@",
    "-T",
    [["."]],
  })

  if vim.v.shell_error ~= 0 then return anchor end

  local distance = #(distance_result[1] or "")

  if distance > 0 then
    return anchor .. " ›" .. distance
  else
    return anchor
  end
end

---Update the current jj branch and set up file watch
local function update_branch()
  active_bufnr = tostring(vim.api.nvim_get_current_buf())
  file_changed:stop()

  local workspace = current_jj_workspace
  if workspace and #workspace > 0 then
    current_jj_branch = get_jj_head(workspace)

    -- Watch .jj/repo/op_heads directory for changes
    local op_heads_dir = workspace .. sep .. ".jj" .. sep .. "repo" .. sep .. "op_heads"
    local stat = vim.uv.fs_stat(op_heads_dir)
    if stat and stat.type == "directory" then
      file_changed:start(op_heads_dir, sep ~= "\\" and {} or 1000, vim.schedule_wrap(function() update_branch() end))
    end
  else
    current_jj_branch = ""
  end

  branch_cache[vim.api.nvim_get_current_buf()] = current_jj_branch
end

---Update current_jj_workspace if it changed
---@param workspace string|nil
local function update_current_workspace(workspace)
  if current_jj_workspace ~= workspace then
    current_jj_workspace = workspace or ""
    update_branch()
  end
end

---Find jj workspace root for a directory
---@param dir_path string|nil directory to search from
---@return string|nil workspace root or nil
function M.find_workspace(dir_path)
  if not jj_available then return nil end

  -- Get file dir so we can search from that dir
  local file_dir = dir_path or vim.fn.expand("%:p:h")

  -- Handle oil.nvim
  if package.loaded.oil then
    local oil = require("oil")
    local ok, dir = pcall(oil.get_current_dir)
    if ok and dir and dir ~= "" then file_dir = vim.fn.fnamemodify(dir, ":p:h") end
  end

  -- Extract correct file dir from terminals
  if file_dir and file_dir:match("term://.*") then
    file_dir = vim.fn.expand(file_dir:gsub("term://(.+)//.+", "%1")) --[[@as string]]
  end

  -- Check cache first
  if workspace_cache[file_dir] ~= nil then
    local cached = workspace_cache[file_dir]
    if dir_path == nil then update_current_workspace(cached ~= "" and cached or nil) end
    return cached ~= "" and cached or nil
  end

  -- Run jj workspace root to find workspace
  local result = vim.fn.systemlist({ "jj", "workspace", "root" })
  local workspace = nil

  if vim.v.shell_error == 0 and result[1] then workspace = vim.trim(result[1]) end

  -- Cache the result (empty string means not a jj workspace)
  workspace_cache[file_dir] = workspace or ""

  if dir_path == nil then update_current_workspace(workspace) end

  return workspace
end

---Check if currently in a jj workspace
---@return boolean
function M.is_jj_workspace() return current_jj_workspace ~= nil and current_jj_workspace ~= "" end

---Initialize jj_branch module
function M.init()
  M.find_workspace()

  -- Update on BufEnter as different buffers may be in different repos
  utils.define_autocmd("BufEnter", "lua require'lualine.components.jj-vcs.jj_branch'.find_workspace()")
end

---Get the current jj branch
---@param bufnr number|nil buffer number
---@return string branch display string
function M.get_branch(bufnr)
  if vim.g.actual_curbuf ~= nil and active_bufnr ~= vim.g.actual_curbuf then M.find_workspace() end

  if bufnr then
    return branch_cache[bufnr] or ""
  else
    branch_cache[vim.api.nvim_get_current_buf()] = current_jj_branch
  end

  return current_jj_branch
end

return M
