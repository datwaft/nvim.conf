-- Adapted from https://github.com/actions/languageservices/tree/main/languageserver#in-neovim

--- Obtains GitHub token using the GitHub CLI.
---@return string | nil
local function get_token()
  if vim.fn.executable("op") == 0 or vim.fn.executable("gh") == 0 then return nil end
  local response = vim.system({ "op", "plugin", "run", "--", "gh", "auth", "token" }, { text = true }):wait()
  if response.code ~= 0 then
    vim.notify(
      string.format("[actionsls] gh auth token failed: %s", vim.trim(response.stderr ?? "")),
      vim.log.levels.WARN
    )
    return nil
  end
  local token = vim.trim(response.stdout)
  return token ~= "" ? token : nil
end

--- Parses a GitHub remote URL to extract the owner and repository name.
---@param url string | nil
---@return string | nil, string | nil
local function parse_remote(url)
  if not url or url == "" then return nil end

  local owner, repo = url:match("^git@github%.com:([^/]+)/([^/%s]+)$")
  if not owner then
    local uri = vim.uri.parse(url)
    if uri and uri.host == "github.com" then
      owner, repo = uri.path:gsub("/+$", ""):match("^/([^/]+)/([^/%s]+)$")
    end
  end
  if owner and repo then
    repo = repo:gsub("%.git$", "")
    if repo ~= "" then return owner, repo end
  end

  return nil
end

--- Retrieves repository information from GitHub CLI.
---@param owner string
---@param repo  string
---@return table | nil
local function get_repo_info(owner, repo)
  if vim.fn.executable("op") == 0 or vim.fn.executable("gh") == 0 then return nil end
  local response = vim
    .system({
      "op",
      "plugin",
      "run",
      "--",
      "gh",
      "api",
      ("repos/%s/%s"):format(owner, repo),
      "--jq",
      "[.id, .owner.type] | @tsv",
    }, { text = true })
    :wait()
  if response.code ~= 0 then
    vim.notify(
      string.format("[actionsls] gh api failed for %s/%s: %s", owner, repo, vim.trim(response.stderr ?? "")),
      vim.log.levels.WARN
    )
    return nil
  end
  local result = vim.trim(response.stdout)

  local id, owner_type = result:match("^(%d+)\t(.+)$")
  if id then
    return {
      id = tonumber(id),
      organizationOwned = owner_type == "Organization",
    }
  end
  return nil
end

--- Obtains repository configuration for the actions language server.
---@param root_dir string | nil
---@return table | nil
local function get_repos_config(root_dir)
  if not root_dir or root_dir == "" then return nil end
  local sys_opts = { cwd = root_dir, text = true }
  local response = vim.system({ "git", "rev-parse", "--show-toplevel" }, sys_opts):wait()
  if response.code ~= 0 then return nil end
  local git_root = vim.trim(response.stdout)
  if git_root == "" then return nil end

  response = vim.system({ "git", "remote", "get-url", "origin" }, sys_opts):wait()
  if response.code ~= 0 then return nil end
  local remote_url = vim.trim(response.stdout)

  local owner, name = parse_remote(remote_url)
  if not owner or not name then return nil end

  local info = get_repo_info(owner, name)

  return {
    {
      id = info?.id ?? 0,
      owner = owner,
      name = name,
      organizationOwned = info?.organizationOwned ?? false,
      workspaceUri = vim.uri.from_fname(git_root),
    },
  }
end

return {
  cmd = { "actions-languageserver", "--stdio" },
  filetypes = { "yaml.ghactions" },
  root_markers = { ".git" },
  before_init = function(params, config)
    params.initializationOptions = {
      sessionToken = get_token(),
      repos = get_repos_config(config.root_dir),
    }
  end,
  handlers = {
    ["actions/readFile"] = function(_, result, ctx)
      if type(result) ~= "table" or type(result.path) ~= "string" then
        return nil, vim.lsp.rpc_response_error(vim.lsp.protocol.ErrorCodes.InvalidParams, "Invalid path")
      end
      if vim.uri.parse(result.path)?.scheme ~= "file" then return vim.NIL, nil end

      local client = vim.lsp.get_client_by_id(ctx.client_id)
      local root = client?.root_dir and vim.uv.fs_realpath(client.root_dir)
      local file_path = vim.uv.fs_realpath(vim.uri.to_fname(result.path))
      if not root or not file_path or not vim.startswith(file_path, root .. "/") then return vim.NIL, nil end
      if vim.uv.fs_stat(file_path)?.type ~= "file" then return vim.NIL, nil end

      local fd = assert(vim.uv.fs_open(file_path, "r", 438))
      local stat, err = vim.uv.fs_fstat(fd)
      local text ---@type string?
      if stat then text, err = vim.uv.fs_read(fd, stat.size, 0) end
      vim.uv.fs_close(fd)
      return assert(text, err), nil
    end,
  },
  init_options = {},
}
