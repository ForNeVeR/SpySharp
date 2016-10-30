<#
.SYNOPSIS
    Installs the dependencies for SpySharp build.
.PARAMETER Directory
    A directory where Paket binary should be placed.
.PARAMETER PaketVersion
    A version of Paket bootstrapper binary to download.
#>
param (
    [string] $Directory = "$PSScriptRoot/.paket",
    [string] $PaketVersion = "2.63.2"
)

$ErrorActionPreference = 'Stop'

$url = "https://github.com/fsprojects/Paket/releases/download/$PaketVersion/paket.bootstrapper.exe"

if (-not (Test-Path -PathType Container $Directory)) {
    Write-Output "Creating .paket directory"
    New-Item -Type Directory $Directory
}

$bootstrapper = "$Directory/paket.bootstrapper.exe"
if (-not (Test-Path $bootstrapper)) {
    Write-Output "Downloading paket bootstrapper"
    Invoke-WebRequest $url -OutFile $bootstrapper
}

if (-not $?) {
    exit -1
}

$paket = "$Directory/paket.exe"
if (-not (Test-Path $paket)) {
    Write-Output "Running paket bootstrapper"
    & $bootstrapper
}

if (-not $?) {
    exit -1
}

Write-Output "Running paket restore"
& $paket restore

exit (-not $?)
