#
# this script updates the nuspec and chocolateyInstall.ps1 with the latest version number
#

function Get-ScriptPath
{
    Split-Path $myInvocation.ScriptName
}

$nuspec_file = Join-Path (Get-ScriptPath) ".\jenkins\jenkins.nuspec"
$install_script = Join-Path (Get-ScriptPath) ".\jenkins\tools\chocolateyInstall.ps1"

function Get-Latest-Jenkins-For-Windows-Version {
    $url = "http://mirrors.jenkins-ci.org/windows/latest"
    $headers = curl.exe -sI $url
    $loc = $headers | Where-Object {$_ -like "Location: *"}
    $version_dot_zip = $loc.Split("/-") | Select-Object -Last 1
    $version = $version_dot_zip.Replace(".zip", "")
    return $version
}

function Get-Current-Version-From-Nuspec {
    $xml = [xml] (Get-Content $nuspec_file)
    return $xml.package.metadata.version
}

$current = Get-Current-Version-From-Nuspec
$latest = Get-Latest-Jenkins-For-Windows-Version
$latest_nuspecformat = "$latest.0.0"

if($current -eq $latest_nuspecformat)
{
    Write-Host "The package is up to date with the latest Jenkins installer ($latest)"
    exit 0
}

Write-Host "A new Jenkins Installer ($latest) is available, updating package ..."

# insert $latest into the nuspec file
$nuspec = [xml] (Get-Content $nuspec_file)
$nuspec.package.metadata.version = $latest_nuspecformat
$nuspec.Save($nuspec_file)

# insert $latest into chocolatey install file
$scrpt = Get-Content $install_script
$new_scrpt = $scrpt -replace "^[\$]version =.*", "`$version = `"$latest`""
$new_scrpt | Set-Content $install_script

# push changes to origin
git commit -a -m "Updated Jenkins package to version $latest"
git push origin master:master

Write-Host "Jenkins package version $latest succesfully pushed."

cd jenkins
rm -force *.nupkg
nuget pack
