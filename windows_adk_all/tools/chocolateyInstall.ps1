$packageName = "WindowsADK.WinPE"
# the $version variable below is automatically set by our update script
# we hardcode the version in this script, so that users can install specific
# versions from Chocolatey.org
#
$url = "http://download.microsoft.com/download/6/A/E/6AEA92B0-A412-4622-983E-5B305D2EBE56/adk/adksetup.exe"

$silentArgs = "/quiet /norestart /log $env:temp\win_adk.log /features +"

try { 
        Install-ChocolateyPackage $packageName 'exe' $silentArgs $url
} catch {
        Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
        throw
}
