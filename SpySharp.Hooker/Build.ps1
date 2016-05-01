param (
    $ilasm = 'ilasm'
)

$ErrorActionPreference = 'Stop'

$outputDirectory = "$PSScriptRoot/bin/Debug"
if (-not (Test-Path $outputDirectory)) {
    New-Item -Type Directory $outputDirectory
}

& $ilasm $PSScriptRoot/Hooks.il /dll /output=$outputDirectory/SpySharp.Hooker.dll /debug /pdb
