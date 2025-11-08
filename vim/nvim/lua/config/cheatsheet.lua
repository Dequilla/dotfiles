local function show_window()
	local test = {
		"Neovim Cheatsheet",
		"=================",
		"Run command and put output in buffer, useful for build-commands to keep track of errors.",
		":new | r ! <cmd>",
	}

	local buffer = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buffer, 0, -1, false, test)
	vim.api.nvim_buf_set_option(buffer, "bufhidden", "wipe") -- Close buffer when window closes
	vim.api.nvim_buf_set_option(buffer, "readonly", true) -- Make it read-only
	vim.api.nvim_buf_set_option(buffer, "filetype", "markdown") -- Add syntax highlighting

	local editor_width = vim.api.nvim_get_option_value("columns", {})
	local editor_height = vim.api.nvim_get_option_value("lines", {})
	local win_width = math.floor(editor_width * 0.6) -- 60% of editor width
	local win_height = math.floor(editor_height * 0.6) -- 60% of editor height
	local row = math.floor((editor_height - win_height) / 2)
	local col = math.floor((editor_width - win_width) / 2)

	local win_config = {
		relative = "editor", -- Position relative to the whole editor
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		style = "minimal", -- No statusline, number column, etc.
		border = "single", -- 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
	}

	local win_handle = vim.api.nvim_open_win(buffer, true, win_config)

	vim.api.nvim_buf_set_keymap(
		buffer,
		"n",
		"<esc>",
		"<Cmd>close!<CR>",
		{ noremap = true, silent = true, nowait = true }
	)

	-- Close if window loses focus
	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = buffer,
		callback = function()
			if vim.api.nvim_win_is_valid(win_handle) then
				vim.api.nvim_win_close(win_handle, true)
			end
		end,
	})
end

vim.api.nvim_create_user_command("Cheat", show_window, {})
