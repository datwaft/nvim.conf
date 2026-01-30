-- Adapted from https://github.com/actions/languageservices/tree/main/languageserver#in-neovim

--- Obtains GitHub token using the GitHub CLI.
---@return string|nil
local function get_token()
  if vim.fn.executable("op") == 0 or vim.fn.executable("gh") == 0 then return nil end
  local response = vim.system({ "op", "plugin", "run", "--", "gh", "auth", "token" }, { text = true }):wait()
  if response.code ~= 0 then
    vim.notify(
      string.format("[actionsls] gh auth token failed: %s", vim.trim(response.stderr or "")),
      vim.log.levels.WARN
    )
    return nil
  end
  local token = vim.trim(response.stdout)
  return token ~= "" and token or nil
end

--- Parses a GitHub remote URL to extract the owner and repository name.
---@param url string
---@return string|nil, string|nil
local function parse_remote(url)
  if not url or url == "" then return nil end

  -- SSH format: "git@github.com:owner/repo.git"
  local owner, repo = url:match("git@github%.com:([^/]+)/([^/%.]+)")
  if owner and repo then return owner, repo:gsub("%.git$", "") end

  -- HTTPS format: "https://github.com/owner/repo.git"
  owner, repo = url:match("github%.com/([^/]+)/([^/%.]+)")
  if owner and repo then return owner, repo:gsub("%.git$", "") end

  return nil
end

--- Retrieves repository information from GitHub CLI.
---@param owner string
---@param repo string
---@return table|nil
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
      string.format("[actionsls] gh api failed for %s/%s: %s", owner, repo, vim.trim(response.stderr or "")),
      vim.log.levels.WARN
    )
    return nil
  end
  local result = vim.trim(response.stdout)

  local id, owner_type = result:match("^(%d+)\t(.+)$")
  if id then return {
    id = tonumber(id),
    organizationOwned = owner_type == "Organization",
  } end
  return nil
end

--- Obtains repository configuration for the actions language server.
---@return table|nil
local function get_repos_config()
  local response = vim.system({ "git", "rev-parse", "--show-toplevel" }, { text = true }):wait()
  if response.code ~= 0 then return nil end
  local git_root = vim.trim(response.stdout)
  if git_root == "" then return nil end

  response = vim.system({ "git", "remote", "get-url", "origin" }, { text = true }):wait()
  if response.code ~= 0 then return nil end
  local remote_url = vim.trim(response.stdout)

  local owner, name = parse_remote(remote_url)
  if not owner or not name then return nil end

  local info = get_repo_info(owner, name)

  return {
    {
      id = info and info.id or 0,
      owner = owner,
      name = name,
      organizationOwned = info and info.organizationOwned or false,
      workspaceUri = vim.uri_from_fname(git_root),
    },
  }
end

return {
  cmd = { "actions-languageserver", "--stdio" },
  filetypes = { "yaml.ghactions" },
  root_markers = { ".git" },
  before_init = function(params)
    params.initializationOptions = {
      sessionToken = get_token(),
      repos = get_repos_config(),
    }
  end,
  handlers = {
    ["actions/readFile"] = function(_, result)
      if type(result.path) ~= "string" then return nil, nil end
      local file_path = vim.uri_to_fname(result.path)
      if vim.fn.filereadable(file_path) == 1 then
        local fd = assert(vim.uv.fs_open(file_path, "r", 438))
        local stat = assert(vim.uv.fs_fstat(fd))
        local text = assert(vim.uv.fs_read(fd, stat.size, 0))
        vim.uv.fs_close(fd)
        return text, nil
      end
      return nil, nil
    end,
  },
  init_options = {},
}
