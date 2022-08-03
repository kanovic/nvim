local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

null_ls.setup({
    sources = {
				-- formatting
				null_ls.builtins.formatting.prettier_standard, -- javascript
				-- linters
        null_ls.builtins.diagnostics.xo, -- javascript
    },
})
