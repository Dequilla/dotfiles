################
# AStyle install
# - Run as elevated
$astyle_path = "$Env:ProgramFiles\astyle"
if(Test-Path "$astyle_path")
{
    Remove-Item -Path "$astyle_path" -Recurse -Force
}

# ORIGINAL
# git clone https://gitlab.com/saalen/astyle.git "$astyle_path"
# $astyle_path_build = "$astyle_path\AStyle\build\vs2022"
# $solution_file="AStyle 2022.sln"
# $astyle_bin_path = "$astyle_path_build\x64\bin"

# CUSTOM
git clone $Env:WORK_GIT_SERVER_URL/autopol/Artistic_Style_kodindentering.git "$astyle_path"
$astyle_path_build = "$astyle_path"
$solution_file="AStyle.sln"
cd $astyle_path_build; msbuild -m -t:clean,build -p:Configuration=Release "$solution_file"
$astyle_bin_path = "$astyle_path_build\AStyle\x64\release"
if(-not ($env:Path -like "*$astyle_bin_path*"))
{
    $env:Path += ";$astyle_bin_path"
    [Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
}
