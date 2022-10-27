$runningDir = Get-Location
$debug = 0
Write-Host "Current Script Location: [ $runningDir ]"

function Get-CommandWithTimeStamp {
    param (
        $Command
    )
    $time = (Get-Date -Format "yyyy/MM/dd HH:mm:ss");
    Add-Content -Path "$runningDir\ip-forward.log" -Value "$time [ INFO ]  >Exec: [ $Command ]"
    $result = (Invoke-Expression $Command)
    $time = (Get-Date -Format "yyyy/MM/dd HH:mm:ss");
    Add-Content -Path "$runningDir\ip-forward.log" -Value "$time [ INFO ]  >Resl: [ $result ]"
    
    if ($debug) {
        $time = (Get-Date -Format "yyyy/MM/dd HH:mm:ss");
        Write-Output "$time [ INFO ]  >Exectg: [ $Command ]" | Out-Host
        $result = (Invoke-Expression $Command)
        $time = (Get-Date -Format "yyyy/MM/dd HH:mm:ss");
        Write-Output "$time [ INFO ]  >Result: [ $result ]"  | Out-Host
    }
    return $result
} 
Get-CommandWithTimeStamp -Command "wsl --list --running"
Get-CommandWithTimeStamp -Command "Get-Location"
$wsl_ip = (Get-CommandWithTimeStamp -Command "(wsl hostname -I).trim().split(' ')[0]")
Get-CommandWithTimeStamp -Command "(netsh interface portproxy add v4tov4 listenport=80 connectport=80 connectaddress=$wsl_ip)"
Get-CommandWithTimeStamp -Command "(netsh interface portproxy show v4tov4)"