local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require "koen.lsp.lsp-installer"
require("koen.lsp.handlers").setup()
require "koen.lsp.null-ls"
