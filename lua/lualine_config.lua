require("lualine").setup({
	options = {
		component_separators = "",
		section_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			{
				"diff",
				colored = false,
			},
			{
				"diagnostics",
				colored = false,
			},
		},
		lualine_c = {
			{
				"filename",
				path = 1, -- Relative path
				shorting_target = 20,
			},
		},
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	tabline = {
		lualine_a = {
			{
				"tabs",
				mode = 1, -- Shows tab_name
			},
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
})
