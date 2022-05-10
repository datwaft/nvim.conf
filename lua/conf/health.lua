local function check()
	require("conf.health.lsp").check()
end

return {
	check = check,
}
