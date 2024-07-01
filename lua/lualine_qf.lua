-- https://github.com/nvim-lualine/lualine.nvim/blob/0a5a66803c7407767b799067986b4dc3036e1983/lua/lualine/extensions/quickfix.lua
-- Copyright (c) 2020-2021 hoob3rt
-- MIT license, see LICENSE for more details.
--
local function total_lines()
	return vim.fn.line(".") .. "/" .. vim.fn.line("$")
end

local function is_loclist()
	return vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0
end

local function label()
	return is_loclist() and "Location List" or "Quickfix List"
end

local function title()
	if is_loclist() then
		return vim.fn.getloclist(0, { title = 0 }).title
	end
	return vim.fn.getqflist({ title = 0 }).title
end

local M = {}

function M.init()
	-- Make sure ft wf doesn't create a custom statusline
	vim.g.qf_disable_statusline = true
end

M.sections = {
	lualine_a = { label },
	lualine_b = { title },
	lualine_z = { total_lines, "location" },
}

M.filetypes = { "qf" }

return M
