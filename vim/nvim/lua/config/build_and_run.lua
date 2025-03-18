if vim.loop.os_uname().sysname == "Windows" then
	vim.cmd(":command! BuildRel :!build_and_run.bat build release")
	vim.cmd(":command! BuildDeb :!build_and_run.bat build debug")
	vim.cmd(":command! Run  :!build_and_run.bat run release")
	vim.cmd(":command! Debug :!build_and_run.bat run debug")
else
	vim.cmd(":command! BuildRel :!./build_and_run build release")
	vim.cmd(":command! BuildDeb :!./build_and_run build debug")
	vim.cmd(":command! Run  :!./build_and_run run release")
	vim.cmd(":command! Debug :!./build_and_run run debug")
end

nmap("<c-b><c-d>", ":BuildDeb<cr>")
nmap("<c-b><c-r>", ":BuildRel<cr>")
nmap("<c-r><c-r>", ":Run<cr>")
nmap("<c-r><c-d>", ":Debug<cr>")

-- TODO: Rewrite
-- Generate build_and_run
vim.cmd([[
" Type: basic (barebone), vs (visual studio)
function! GenerateDefaultBuildAndRun(type)
    if filereadable(expand("build_and_run.bat"))
        echo "ERROR: build_and_run.bat already exists."
        return
    endif

    if has("win32")
        echo "Creating build script for windows."

        :let buildCmd = "echo \"Running: %mode% => %target%\""
        if a:type == "vs"
            :let buildCmd = "msbuild.exe -maxCpuCount"
        endif

        let buildScript =<< trim EOF1
            echo off
            set mode=%1
            set target=%2
            IF "%mode%"=="run" (
                IF "%target%"=="debug" (
                    ----build_cmd----
                )
                IF "%target%"=="release" (
                    ----build_cmd----
                )
            )
            IF "%mode%"=="build" (
                IF "%target%"=="debug" (
                    ----build_cmd----
                )
                IF "%target%"=="release" (
                    ----build_cmd----
                ) 
            )
        EOF1


        let buildScript = split(substitute(join(buildScript, "\n"), "----build_cmd----", buildCmd, "g"), "\n")
        :call writefile(buildScript, "build_and_run.bat") 

        :echo buildScript

        " Add build_and_run to gitignore if it exist
        if filereadable(expand(".gitignore"))
            echo "Found .gitignore file, appending build_and_run.bat to it."
            :! @echo.>>".gitignore" 
            :! @echo build_and_run.bat>>.gitignore
        endif
    else
        echo "Creating build script for linux."
        let buildScript =<< trim EOF2
	    #!/bin/bash
            mode=$1
            target=$2
            if [ "$mode" = "run" ]; then
              if [ "$target" = "debug" ]; then
                  echo "$mode => $target"
              elif [ "$target" = "release" ]; then
                  echo "$mode => $target"
              fi
            elif [ "$mode" = "build" ]; then
              if [ "$target" = "debug" ]; then
                  echo "$mode => $target"
              elif [ "$target" = "release" ]; then
                  echo "$mode => $target"
              fi
            fi
        EOF2
        :call writefile(buildScript, "build_and_run") 
        :! chmod +x "build_and_run"

        " Add build_and_run to gitignore if it exist
        if filereadable(expand(".gitignore"))
            :! echo "Found .gitignore file, appending build_and_run to it."
            :! echo -e "build_and_run\n" >> .gitignore
        endif
    endif
endfunction
:command! GenBuildScript :call GenerateDefaultBuildAndRun("basic")
:command! GenBuildScriptVS :call GenerateDefaultBuildAndRun("vs")
]])
