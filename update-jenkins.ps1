$nuspec_file = ".\jenkins\jenkins.nuspec"

function Get-Latest-Jenkins-For-Windows-Version {
    $url = "http://mirrors.jenkins-ci.org/windows/latest"
    $headers = curl -sI $url 
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

# insert $latest into chocolatey install file

# push changes to origin
