local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		formatting.eslint_d.with({ extra_args = { "--resolve-plugins-relative-to=/home/ian/.local/lib" } }),
    code_actions.eslint_d.with({ extra_args = { "--resolve-plugins-relative-to=/home/ian/.local/lib" } }),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
    diagnostics.eslint_d.with({ extra_args = { "--resolve-plugins-relative-to=/home/ian/.local/lib"}}),
    -- diagnostics.flake8
	},
  on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
        end
    end,
})
