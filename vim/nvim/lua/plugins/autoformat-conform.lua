return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = false, cpp = false }
			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 500,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters = {
			astyle = {
				prepend_args = {
					"--style=allman",
					"--mode=c",
					"--indent=force-tab",
					"--break-closing-braces",
					"--unpad-paren",
					"--pad-include",
					"--pad-oper",
					"--pad-paren-in",
					"--squeeze-lines=2",
					"--squeeze-ws",
					"--align-pointer=name",
					"--align-reference=name",
					"--indent-namespaces",
					"--indent-switches",
					"--indent-preproc-block",
					"--indent-preproc-define",
				},
				inherit = true,
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			cpp = { "astyle" },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
		},
	},
}
