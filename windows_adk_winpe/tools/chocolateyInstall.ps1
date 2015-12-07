$packageName = "WindowsADK.WinPE"
# the $version variable below is automatically set by our update script
# we hardcode the version in this script, so that users can install specific
# versions from Chocolatey.org
#
$url = "http://download.microsoft.com/download/8/1/9/8197FEB9-FABE-48FD-A537-7D8709586715/adk/adksetup.exe"

$silentArgs = "/quiet /norestart /log $env:temp\win_adk.log /features OptionId.DeploymentTools OptionId.WindowsPreinstallationEnvironment"

try {
        Install-ChocolateyPackage $packageName 'exe' $silentArgs $url
} catch {
        Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
        throw
}
