$packageName = "WindowsADK.WinPE"
# the $version variable below is automatically set by our update script
# we hardcode the version in this script, so that users can install specific
# versions from Chocolatey.org
#
$url = "http://download.microsoft.com/download/3/8/B/38BBCA6A-ADC9-4245-BCD8-DAA136F63C8B/adk/adksetup.exe"

$silentArgs = "/quiet /norestart /log $env:temp\win_adk.log /features +"

try {
        Install-ChocolateyPackage $packageName 'exe' $silentArgs $url
} catch {
        Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
        throw
}
