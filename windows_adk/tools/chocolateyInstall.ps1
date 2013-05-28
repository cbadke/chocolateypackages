$packageName = "WindowsADK.WinPE"
# the $version variable below is automatically set by our update script
# we hardcode the version in this script, so that users can install specific
# versions from Chocolatey.org
#
$url = "http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/adksetup.exe"

$silentArgs = "/quiet /norestart /log $env:temp\win_adk.log"

try { 
        Install-ChocolateyPackage $packageName 'exe' $silentArgs $url
} catch {
        Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
        throw
}
