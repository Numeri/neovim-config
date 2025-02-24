local status_ok, lsp_installer = pcall(require, "mason")
if not status_ok then
	return
end
lsp_installer.setup()

local lspconfig = require("lspconfig")

local servers = { "jsonls", "lua_ls", "pylsp", "taplo", "bashls", "html", "rust_analyzer" }

lsp_installer.setup {
	ensure_installed = servers,
}

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach(server),
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
	 	opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end

	lspconfig[server].setup(opts)
end
