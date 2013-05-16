function Get-Latest-Jenkins-For-Windows-Version {
    $url = "http://mirrors.jenkins-ci.org/windows/latest"
    $headers = curl -sI $url 
    $loc = $headers | Where-Object {$_ -like "Location: *"}
    $version_dot_zip = $loc.Split("/-") | Select-Object -Last 1
    $version = $version_dot_zip.Replace(".zip", "")
    return $version
}

$latest = Get-Latest-Jenkins-For-Windows-Version
Write-Host $latest

# insert $latest into the nuspec file

# insert $latest into chocolatey install file

# push changes to origin
