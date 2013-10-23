$packageName = "PSReadLine"
$zipFile = "PSReadline.zip"
$url = "https://github.com/lzybkr/PSReadLine/raw/0629969e3d1e0781493f07d2512b6bb37ff1539a/$zipFile"
$url64 = $url

try {
    $chocTempDir = Join-Path $env:TEMP "chocolatey"
    $tempDir = Join-Path $chocTempDir $packageName
    if (-Not (Test-Path -PathType Container $tempDir)) {mkdir $tempDir}
    $file = Join-Path $tempDir $zipFile

    $source = Join-Path $tempDir $packageName

    Get-ChocolateyWebFile $packageName $file $url $url64
    Get-ChocolateyUnzip $file $source "" $packageName

    $dest64 = "C:\Windows\system32\WindowsPowerShell\v1.0\Modules\"
    $dest32 = "C:\Windows\sysWOW64\WindowsPowerShell\v1.0\Modules\"

    $command = "Copy-Item -Force -Recurse `'$source`' `'$dest64`';Copy-Item -Force -Recurse `'$source`' `'$dest32`'"

    Start-ChocolateyProcessAsAdmin $command

    Remove-Item -Recurse -Force $tempDir

    Write-ChocolateySuccess $packageName
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
