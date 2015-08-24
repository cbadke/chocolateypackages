$packageName = "WindowsADK.WinPE"
# the $version variable below is automatically set by our update script
# we hardcode the version in this script, so that users can install specific
# versions from Chocolatey.org
#
$url = "http://download.microsoft.com/download/0/A/A/0AA382BA-48B4-40F6-8DD0-BEBB48B6AC18/adk/adksetup.exe"

$silentArgs = "/quiet /norestart /log $env:temp\win_adk.log"

try {
        Install-ChocolateyPackage $packageName 'exe' $silentArgs $url
} catch {
        Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
        throw
}
