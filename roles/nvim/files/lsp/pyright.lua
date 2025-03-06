return {
	cmd = { "pyright-langserver", "--stdio" },
	on_init = function(client)
		client.offset_encoding = "utf-8"
	end,
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.cfg", "setup.py", "requirements.txt" },
	settings = {
		pyright = {
			-- Leave that to ruff.
			disableOrganizeImports = false,
		},
		python = {
			analysis = {
				autoImportCompletions = true,
				autoSearchPaths = true,
			},
		},
	},
}
