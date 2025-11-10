echo "Installing dependecies for PowerShell LSP"

$home_path = "C:\develop\"
$pses_path = "$home_path\PowerShellEditorServices"
$rel_url = "https://github.com/PowerShell/PowerShellEditorServices/releases/latest/download/PowerShellEditorServices.zip"
Invoke-WebRequest  -Uri "$rel_url" -OutFile "$pses_path.zip" -PassThru
if( Test-Path -Path "$pses_path.zip" )
{
    Expand-Archive -Path "$pses_path.zip" -Force -DestinationPath "$pses_path"
    Remove-Item -Path "$pses_path.zip" -Force
}
else
{
    Exit 1
}
