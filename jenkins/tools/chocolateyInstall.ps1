$packageName = "jenkins"
$zipFile = "jenkins-1.499.zip"
$msiFile = "jenkins-1.499.msi"
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
  
        Write-ChocolateySuccess "$packageName"
} catch {
        Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
        throw
}
