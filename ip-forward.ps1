$runningDir = $PSScriptRoot
$debug = 0
Write-Host "Current Script Location: [ $runningDir ]"
Add-Content -Path "$runningDir\ip-forward.log" -Value "#############################################################################################"
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

# Get-CommandWithTimeStamp -Command "wsl --list --running"
# Get-CommandWithTimeStamp -Command "Get-Location"
$wsl_ip = (Get-CommandWithTimeStamp -Command "(wsl hostname -I).trim().split(' ')[0]")
Get-CommandWithTimeStamp -Command "(netsh interface portproxy add v4tov4 listenport=80 connectport=80 connectaddress=$wsl_ip)"
Get-CommandWithTimeStamp -Command "(netsh interface portproxy add v4tov4 listenport=9987 connectport=9987 connectaddress=$wsl_ip)"
Get-CommandWithTimeStamp -Command "(netsh interface portproxy add v4tov4 listenport=10011 connectport=10011 connectaddress=$wsl_ip)"
Get-CommandWithTimeStamp -Command "(netsh interface portproxy add v4tov4 listenport=30033 connectport=30033 connectaddress=$wsl_ip)"
Get-CommandWithTimeStamp -Command "(netsh interface portproxy show v4tov4)"
## Bypass netsh UDP limitation using socat
Get-CommandWithTimeStamp -Command "(Start-Process -FilePath 'C:\socat-1.7.3.2-1-x86_64\socat.exe' -ArgumentList 'udp4-listen:9987,reuseaddr,fork tcp:localhost:9987' -WindowStyle Hidden)"
Get-CommandWithTimeStamp -Command "(Start-Process -FilePath 'wsl' -ArgumentList 'socat tcp4-listen:9987,reuseaddr,fork UDP:localhost:9987' -WindowStyle Hidden)"

Add-Content -Path "$runningDir\ip-forward.log" -Value ""


