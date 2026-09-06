# PowerShell test runner for vim-uefi test suite

$ErrorActionPreference = 'Stop'
$scriptDir = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Path }
$repoRoot = Split-Path -Parent $scriptDir
$minivimrc = Join-Path $scriptDir 'minivimrc'
$runAll = Join-Path $scriptDir 'run_all.vim'
$logFile = Join-Path $scriptDir 'test.log'

if (Test-Path $logFile) {
    Remove-Item -Force $logFile
}

Write-Host "Running vim-uefi automated test suite..."
$vimOutput = vim --clean -Nu $minivimrc -es -S $runAll 2>&1
$exitCode = $LASTEXITCODE

if (Test-Path $logFile) {
    Get-Content $logFile
} elseif ($vimOutput) {
    $vimOutput | ForEach-Object { Write-Host $_ }
}

if ($exitCode -ne 0) {
    Write-Error "Test suite failed with exit code $exitCode"
}

exit $exitCode
