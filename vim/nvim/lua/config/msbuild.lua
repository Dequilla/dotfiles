if vim.fn.has("win32") == 1 then
	local function string_ends_with(str, suffix)
		return string.sub(str, -#suffix) == suffix
	end

	local last_msbuild_bufnr = nil

	local function run_msbuild_with_params(fnargs)
		-- Run MSBuild with certain parameters
		local fargs = fnargs["fargs"] -- list of args

		local flags = {}
		local positionals = {}

		-- Parse args
		local i = 1
		while i <= #fargs do
			local arg = fargs[i]

			if string.sub(arg, 1, 1) == "-" then
				local next_arg = fargs[i + 1]

				if next_arg and string.sub(next_arg, 1, 1) ~= "-" then
					flags[arg] = next_arg
					i = i + 2
				else
					flags[arg] = true
					i = i + 1
				end
			else
				-- Positional
				table.insert(positionals, arg)
				i = i + 1
			end
		end

		if flags["-d"] and flags["-r"] then
			vim.notify("ERROR: cannot mix debug and release mode (flags -d and -r)")
			return false
		end

		local cmd = "MSBuild"
		-- Check and setup configuration to run
		if flags["-d"] then
			cmd = cmd .. " -p:Configuration=Debug"
		elseif flags["-r"] then
			cmd = cmd .. " -p:Configuration=Release"
		end

		if flags["-m"] then
			local threadcount = flags["-m"]
			if threadcount and tonumber(threadcount, 10) then
				cmd = cmd .. " -m " .. threadcount
			else
				cmd = cmd .. " -m"
			end
		end

		if flags["-t"] then
			cmd = cmd .. " -t:" .. flags["-t"]
		end

		local slnpath = positionals[#positionals]
		local foundsln = ""

		local searchstr = ""
		if slnpath == nil or slnpath == "" then
			searchstr = vim.fn.resolve("*.sln")
		elseif string_ends_with(slnpath, ".sln") then
			searchstr = vim.fn.resolve(slnpath)
		else
			searchstr = vim.fn.resolve(slnpath .. "/*.sln")
		end
		foundsln = vim.fn.glob(searchstr)

		local foundsln_count = 0
		if #foundsln < 1 then
			foundsln_count = 0
		else
			foundsln_count = #vim.split(foundsln, "\n")
		end

		if foundsln_count > 1 then
			vim.notify("ERROR: Too many .sln files found, please specify which.\n" .. foundsln)
			return false
		elseif foundsln_count < 1 then
			local p = ""
			if slnpath and #slnpath > 1 then
				p = slnpath
			else
				p = vim.loop.cwd()
			end
			vim.notify("ERROR: No .sln found at " .. p)
			return false
		end

		cmd = cmd .. " " .. foundsln

		-- Check if we already have a buffer
		if last_msbuild_bufnr and vim.api.nvim_buf_is_valid(last_msbuild_bufnr) then
			-- Delete the old buffer. This also closes its window.
			-- We use pcall (protected call) for safety, just in case.
			pcall(vim.api.nvim_buf_delete, last_msbuild_bufnr, { force = true })
		end
		vim.cmd("botright term " .. cmd)
		last_msbuild_bufnr = vim.fn.bufnr()

		return true
	end

	local description = [[
	Thin wrapper for MSBuild command. 
	:h msbuild 
	]]
	vim.api.nvim_create_user_command(
		"Msbuild",
		run_msbuild_with_params,
		{ nargs = "*", complete = "file", desc = description }
	)
end
