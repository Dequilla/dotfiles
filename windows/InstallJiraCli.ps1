echo "Installing jira-cli!"

# Install via release github download
$home_path = "C:\develop\"
$out_path = "$home_path\jira-cli"
$rel_url = "https://github.com/ankitpokhrel/jira-cli/releases/latest/download/jira_1.7.0_windows_x86_64.zip"

Invoke-WebRequest  -Uri "$rel_url" -OutFile "$out_path.zip" -PassThru
if( Test-Path -Path "$out_path.zip" )
{
    Write-Output "Installing Jira-cli to $out_path"
    Expand-Archive -Path "$out_path.zip" -Force -DestinationPath "$out_path"
    Remove-Item -Path "$out_path.zip" -Force
} else
{
    Exit 1
}
