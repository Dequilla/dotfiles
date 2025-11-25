# TODO
- Add this `type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh 10.0.0.15 "cat >> .ssh/authorized_keys"` as ssh-copy-id alias or command to profile
    - Edit to allow to select which key file, maybe prompt user with list
- Add this history command:
```powershell
function hist { 
  $find = $args; 
  Write-Host "Finding in full history using {`$_ -like `"*$find*`"}"; 
  Get-Content (Get-PSReadlineOption).HistorySavePath | ? {$_ -like "*$find*"} | Get-Unique | more 
}
```
