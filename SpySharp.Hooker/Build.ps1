param (
    [switch] $Force,
    $SourceDirectory = $PSScriptRoot,
    $OutputDirectory = "$PSScriptRoot/bin/Debug",
    $OutputFile = "$OutputDirectory/SpySharp.Hooker.dll",
    $ilasm = 'C:/Windows/Microsoft.NET/Framework64/v4.0.30319/ilasm.exe'
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $OutputDirectory)) {
    Write-Output "Creating $OutputDirectory"
    New-Item -Type Directory $OutputDirectory
}

function Get-FileDate($fileName) {
    $file = Get-ChildItem $fileName
    if ($file -eq $null) {
        [DateTime]::MinValue
    } else {
        $file.LastWriteTimeUtc
    }
}

$sourceDate = Get-FileDate $SourceDirectory/Hooker.il
$targetDate = Get-FileDate $OutputFile

if ($Force -or ($sourceDate -gt $targetDate)) {
    & $ilasm $SourceDirectory/Hooker.il /dll /output=$OutputFile /debug /pdb
    exit $LastExitCode
}
