vim.keymap.set("n", "<Leader>b", "Obreakpoint()<esc>")

local snapshot_query = vim.treesitter.query.parse(
	"python",
	[[
		[
			(call
				function: (identifier) @funcname
				(#eq? @funcname "snapshot"))
			((identifier) @idname
				(#eq? @idname "snapshot"))
		]
	]]
)

local name_kwarg_query = vim.treesitter.query.parse(
	"python",
	[[
		(keyword_argument
				name: (identifier) @kwname
				(#eq? @kwname "name"))
	]]
)

local function find_node_ancestor(type, node)
	if not node then
		return nil
	end
	if type == node:type() then
		return node
	end
	return find_node_ancestor(type, node:parent())
end

local function view_snapshot()
	local node = vim.treesitter.get_node()
	local parent = find_node_ancestor("assert_statement", node)
	if not parent then
		vim.notify("Could not find parent assert statement.", vim.log.error)
		return
	end

	local buf = vim.api.nvim_get_current_buf()
	local test_class_node = find_node_ancestor("class_definition", node)
	local class_name
	if test_class_node then
		class_name = vim.treesitter.get_node_text(test_class_node:named_child(0), buf)
	end
	local test_def_node = find_node_ancestor("function_definition", node)
	assert(test_def_node ~= nil)
	local test_name = vim.treesitter.get_node_text(test_def_node:named_child(0), buf)
	local test_pattern
	if class_name then
		test_pattern = class_name .. "\\." .. test_name
	else
		test_pattern = test_name
	end

	local captures = vim.iter(snapshot_query:iter_captures(parent, buf))
	local _, snapshot_func_node, _, _ = captures:next()
	if not snapshot_func_node then
		vim.notify("Could not find snapshot call.", vim.log.error)
		return
	end
	assert(captures:next() == nil)

	local call_node = snapshot_func_node:parent()
	captures = vim.iter(name_kwarg_query:iter_captures(call_node, buf))
	local _, kwarg_key_node, _, _ = captures:next()
	local snapshot_name
	if kwarg_key_node then
		local kwarg_node = kwarg_key_node:parent()
		-- The second child of kwarg_node is the value, and the second named child
		-- of the value is the string content.
		local snapshot_name_node = kwarg_node:named_child(1):named_child(1)
		snapshot_name = vim.treesitter.get_node_text(snapshot_name_node, buf)
	else
		snapshot_name = nil
	end

	local test_file_path = vim.api.nvim_buf_get_name(buf)
	local snapshot_file_path = vim.fs.joinpath(
		vim.fs.dirname(test_file_path),
		"__snapshots__",
		-- Replace the .py extension with .ambr.
		string.sub(vim.fs.basename(test_file_path), 0, -4) .. ".ambr"
	)

	vim.cmd(":edit" .. snapshot_file_path)
	local parametrize_name_re = "(\\[.*\\])?"
	local search_str = "\\v^# name: " .. test_pattern .. parametrize_name_re
	if snapshot_name then
		search_str = search_str .. "\\[" .. snapshot_name .. "\\]"
	end
	search_str = search_str .. "$"
	vim.cmd("/" .. search_str)
	vim.api.nvim_feedkeys("zt", "n", false)
end

vim.keymap.set("n", "<Leader>vs", view_snapshot, { buffer = true, desc = "Open test snapshot." })
