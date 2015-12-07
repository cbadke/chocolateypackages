$packageName = "jenkins"
# the $version variable below is automatically set by our update script
# we hardcode the version in this script, so that users can install specific
# versions from Chocolatey.org
$version = "1.640"
$zipFile = "jenkins-$version.zip"
$msiFile = "jenkins.msi"
$url = "http://mirrors.jenkins-ci.org/windows/$zipFile"
$url64 = $url
$silentArgs = "/quiet"
$validExitCodes = @(0)

try {
        $chocTempDir = Join-Path $env:TEMP "chocolatey"
        $tempDir = Join-Path $chocTempDir "$packageName"
        if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
        $file = Join-Path $tempDir $zipFile

        Get-ChocolateyWebFile $packageName $file $url $url64
        Get-ChocolateyUnzip $file $tempDir "" $packageName

        $file = Join-Path $tempDir $msiFile

        Install-ChocolateyInstallPackage $packageName 'msi' $silentArgs $file -validExitCodes $validExitCodes

} catch {
        throw
}
