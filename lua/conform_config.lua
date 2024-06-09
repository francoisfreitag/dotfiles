local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		htmldjango = { "djlint" },
		lua = { "stylua" },
		python = function(bufnr)
			if conform.get_formatter_info("ruff_format", bufnr).available then
				return { "ruff_fix", "ruff_format" }
			else
				return { "isort", "black" }
			end
		end,
		["*"] = { "trim_newlines", "trim_whitespace" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
})
