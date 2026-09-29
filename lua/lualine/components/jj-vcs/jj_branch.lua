local M = {}

const async = vim.async
const is_jj_available = vim.fn.executable("jj") == 1

-- Cached repository state.
local current_jj_workspace = ""
local branch_cache = {} -- Last known display for each `jj` workspace.
local workspace_cache = {} -- Workspace roots by directory; `""` means no workspace.

-- Buffer associations.
local buffer_directories = {}
local buffer_workspaces = {}

-- Async tasks and pending refreshes.
local workspace_tasks = {}
local branch_tasks = {}
local branch_pending = {}

-- Watch `op_heads` for repository operations.
const file_changed = assert(vim.uv.new_fs_event())

-- Ancestor bookmarks and `trunk()` supply the display anchor and distance baseline.
const closest_bookmark_revset = "heads(::@ & bookmarks()) | trunk()"
const branch_revset = "(" .. closest_bookmark_revset .. ") | ((" .. closest_bookmark_revset .. ")..@)"
const branch_template = 'if(self.contained_in("' .. closest_bookmark_revset
  .. '"), "A" ++ coalesce(bookmarks.join(","), change_id.shortest(4)), "D") ++ "\\n"'

--- Query the bookmark and distance in one asynchronous `jj log` call.
---@param workspace string
---@return string
local function get_jj_head(workspace)
  const result = async.await(3, vim.system, {
    "jj",
    "log",
    "--repository",
    workspace,
    "--ignore-working-copy",
    "--no-graph",
    "--color",
    "never",
    "-r",
    branch_revset,
    "-T",
    branch_template,
  }, { text = true }
  ) --[[@as vim.SystemCompleted]]

  if result.code ~= 0 then return "" end

  local anchor = ""
  local distance = 0
  for line in (result.stdout ?? ""):gmatch("[^\n]+") do
    if line == "D" then
      distance = distance + 1
    elseif line:sub(1, 1) == "A" then
      if anchor == "" then anchor = vim.trim(line:sub(2)):match("^[^,]+") ?? "" end
    else
      error("Unexpected `jj` statusline output: " .. line)
    end
  end

  if anchor == "" then return "" end
  return distance > 0 ? anchor .. " ›" .. distance : anchor
end

--- Keep one refresh in flight, with one follow-up for changes during the query.
---@param workspace string
local function update_branch(workspace)
  if branch_tasks[workspace] then
    branch_pending[workspace] = true
    return
  end

  branch_tasks[workspace] = async.run(
    ---@return nil
    function()
      repeat
        branch_pending[workspace] = nil
        const branch = get_jj_head(workspace)
        -- `vim.system` completes in a fast callback; resume before touching the UI.
        async.await(vim.schedule)
        branch_cache[workspace] = branch
        if current_jj_workspace == workspace then require("lualine").refresh() end
      until not branch_pending[workspace]
      return nil
    end
  ):detach():raise_on_error()
  branch_tasks[workspace]:on_complete(function()
    branch_tasks[workspace] = nil
    branch_pending[workspace] = nil
  end)
end

--- Switch the watcher only when the active workspace changes.
---@param workspace string
local function update_current_workspace(workspace)
  if current_jj_workspace == workspace then return end
  current_jj_workspace = workspace
  file_changed:stop()

  if workspace == "" then return end

  const op_heads_dir = workspace .. "/.jj/repo/op_heads"
  if vim.uv.fs_stat(op_heads_dir)?.type == "directory" then
    file_changed:start(
      op_heads_dir, {},
      vim.schedule_wrap(function()
        if current_jj_workspace == workspace then update_branch(workspace) end
      end)
    )
  end
  update_branch(workspace)
end

--- Return a cached workspace root and discover uncached directories asynchronously.
---@param dir_path string | nil
---@return string | nil
function M.find_workspace(dir_path)
  if not is_jj_available then return nil end

  const bufnr = vim.api.nvim_get_current_buf()
  local file_dir = dir_path ?? vim.fn.expand("%:p:h")

  -- Handle `oil.nvim`.
  if package.loaded.oil then
    const oil = require("oil")
    const ok, dir = pcall(oil.get_current_dir)
    if ok and dir and dir ~= "" then file_dir = vim.fn.fnamemodify(dir, ":p:h") end
  end

  -- Extract the directory from terminal buffer names.
  if file_dir and file_dir:match("term://.*") then
    file_dir = vim.fn.expand(file_dir:gsub("term://(.+)//.+", "%1")) --[[@as string]]
  end

  if dir_path == nil then
    buffer_directories[bufnr] = file_dir
    buffer_workspaces[bufnr] = workspace_cache[file_dir] ?? ""
    update_current_workspace(buffer_workspaces[bufnr])
  end

  const cached = workspace_cache[file_dir]
  if cached ~= nil then return cached ~= "" ? cached : nil end
  if workspace_tasks[file_dir] then return nil end

  workspace_tasks[file_dir] = async.run(
    ---@return nil
    function()
      const result = async.await(
        3, vim.system, { "jj", "workspace", "root" }, { text = true }
      ) --[[@as vim.SystemCompleted]]
      async.await(vim.schedule)
      const workspace = result.code == 0 ? vim.trim(result.stdout ?? "") : ""
      workspace_cache[file_dir] = workspace
      for buf, dir in pairs(buffer_directories) do
        if dir == file_dir then buffer_workspaces[buf] = workspace end
      end
      if buffer_directories[vim.api.nvim_get_current_buf()] == file_dir then
        update_current_workspace(workspace)
        require("lualine").refresh()
      end
      return nil
    end
  ):raise_on_error()
  workspace_tasks[file_dir]:on_complete(function()
    workspace_tasks[file_dir] = nil
  end)

  return nil
end

---@return boolean
function M.is_jj_workspace()
  return current_jj_workspace ~= ""
end

--- Start discovery and keep buffer associations up to date.
function M.init()
  M.find_workspace()
  const group = vim.api.nvim_create_augroup("LualineJj", { clear = true })
  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    callback = function()
      M.find_workspace()
    end,
  })
  vim.api.nvim_create_autocmd("BufWipeout", {
    group = group,
    callback = function(event)
      buffer_directories[event.buf] = nil
      buffer_workspaces[event.buf] = nil
    end,
  })
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
      file_changed:stop()
      file_changed:close()
    end,
  })
end

--- Rendering only reads cached state, including for inactive buffers.
---@param bufnr number | nil
---@return string
function M.get_branch(bufnr)
  return branch_cache[buffer_workspaces[bufnr ?? vim.api.nvim_get_current_buf()] ?? ""] ?? ""
end

return M
