Import-Module ".\src\utils\Path.ps1"
Import-Module ".\src\utils\Version.ps1"

# Find the specified version argument in the command-line arguments
$version = Find-VersionArgument $args

# Create necessary folders for ErlangLS
$erlangLsVersionPath = Get-PertuManagerVersionDirectory "erlang-ls" $version
Remove-Item $erlangLsVersionPath -Force -Recurse -ErrorAction SilentlyContinue
[void](New-Item -ItemType Directory -Path $erlangLsVersionPath -Force)

# Download the source code of ErlangLS
$sourceUrl = "https://github.com/erlang-ls/erlang-ls/archive/refs/tags/$version.zip"
$sourceZip = Join-Path -Path $erlangLsVersionPath -ChildPath "source.zip"
Invoke-WebRequest -Uri $sourceUrl -OutFile $sourceZip

# Unzip the source code
Expand-Archive -Path $sourceZip -DestinationPath $erlangLsVersionPath

# Compile ErlangLS
$sourceDirectory = Get-GitHubRepositoryDirectory "erlang-ls" "erlang_ls" $version
Set-Location $sourceDirectory

rebar3 escriptize
rebar3 as dap escriptize

# Clean up
Set-Location $erlangLsVersionPath

Remove-Item -Path $sourceZip

Move-Item -Path (Join-Path -Path $sourceDirectory -ChildPath "_build\default\bin\erlang_ls") -Destination ".\erlang_ls" -Force
Move-Item -Path (Join-Path -Path $sourceDirectory -ChildPath "_build\default\bin\erlang_ls.cmd") -Destination ".\erlang_ls.cmd" -Force
Move-Item -Path (Join-Path -Path $sourceDirectory -ChildPath "_build\dap\bin\els_dap") -Destination ".\els_dap" -Force
Move-Item -Path (Join-Path -Path $sourceDirectory -ChildPath "_build\dap\bin\els_dap.cmd") -Destination ".\els_dap.cmd" -Force

Remove-Item $sourceDirectory -Force -Recurse -ErrorAction SilentlyContinue
