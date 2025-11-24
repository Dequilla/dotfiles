local function show_window()
	local test = {
		"# Neovim Cheatsheet",
		" ",
		"## --- Run Commands ---",
		"Run command and put output in buffer, useful for build-commands to keep errors open in persistent buffer.",
		"Option 1 #> `:term <cmd>`",
		"Option 2 #> `:new | r ! <cmd>`",
		" ",
		"## --- MSBuild ---",
		"Run MSBuild command through thin wrapper, `:h msbuild`",
		"Example: `:Msbuild -d -t Clean,Build ./build/`",
		"This opens in a new term-buffer (removing old one if one exists)",
		"TIP: In the terminal buffer that pops up, `gf` goes to file at path, and `gF` also considers the line if one is present",
		" ",
		"## --- Spell checking ---",
		"This config has a helper method to toggle spellcheck, run one of the following:",
		"`:SpellCheck` or press `sc`",
		"Change language via: `:setlocal spelllang=en_us`",
		"Jump to prev/next wrong: `[s` / `]s` \t Add good word: `zg` \t Add bad word: `zw` \t Ask suggestions: `z=`",
		"More info: `:h spell`",
		" ",
		"## --- Surround ---",
		"This config uses mini.surround to enable easy to use surround commands.",
		"`sa[character]` to add surround \t `sr[replace][new]` to replace surrounding",
		"More info: `:h surround`",
		" ",
		"## --- Command History ---",
		"When running a command through `:` pressing `<c-f>` opens a history buffer with ran commands where you can run commands.",
		"The absolute largest benefit of this buffer is that you can write commands and use all our vim keymaps, such as multiple cursors.",
		"## --- Replacing --- ",
		"1. Select some text (<c-q> or <visual mode>)",
		'2. Yank (Places in register ", default register)',
		'3. Write replace command: `:\'<,\'>s/Ctrl-R "/replacement/g` (<c-r>" selects register ")',
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
