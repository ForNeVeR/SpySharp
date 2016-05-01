param (
    $ilasm = 'C:/Windows/Microsoft.NET/Framework64/v4.0.30319/ilasm.exe'
)

$ErrorActionPreference = 'Stop'

$outputDirectory = "$PSScriptRoot/bin/Debug"
if (-not (Test-Path $outputDirectory)) {
    New-Item -Type Directory $outputDirectory
}

& $ilasm $PSScriptRoot/Hooker.il /dll /output=$outputDirectory/SpySharp.Hooker.dll /debug /pdb
