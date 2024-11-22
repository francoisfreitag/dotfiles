local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		htmldjango = { "djlint" },
		lua = { "stylua" },
		python = function(bufnr)
			if os.getenv("NO_FORMAT") then
				return { "isort" }
			end
			if conform.get_formatter_info("ruff_format", bufnr).available then
				return { "ruff_fix", "ruff_format" }
			end
			return { "isort", "black" }
		end,
		["*"] = { "trim_newlines", "trim_whitespace" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 2000,
	},
})
