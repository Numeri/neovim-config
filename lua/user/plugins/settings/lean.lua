local status_ok, lean = pcall(require, "lean")
if not status_ok then
	return
end

lean.setup{
  lsp = { on_attach = require("user.lsp.handlers").on_attach(lean) },
  mappings = true,
}
