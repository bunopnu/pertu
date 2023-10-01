Import-Module ".\src\utils\Path.ps1"
Import-Module ".\src\utils\Version.ps1"

# Check if version given
$version = Find-VersionArgument $args

# Create necessary folders
$elsPath = Get-PertuManagerVersionDir "erlang-ls" $version
Remove-Item $elsPath -Force -Recurse -ErrorAction SilentlyContinue
[void](New-Item -ItemType Directory -Path $elsPath -Force)

# Download source code
$sourceUrl = "https://github.com/erlang-ls/erlang-ls/archive/refs/tags/$version.zip"
$sourceZip = "$elsPath\source.zip"
Invoke-WebRequest -Uri $sourceUrl -OutFile $sourceZip

# Unzip source code
Expand-Archive $sourceZip -DestinationPath $elsPath

# Compile ErlangLS
$sourceDirectory = Get-GitHubDir "erlang-ls" "erlang_ls" $version
Set-Location $sourceDirectory

rebar3 escriptize
rebar3 as dap escriptize

# Clean up
Set-Location $elsPath

Remove-Item -Path $sourceZip

Move-Item -Path "$sourceDirectory\_build\default\bin\erlang_ls" -Destination ".\erlang_ls" -Force
Move-Item -Path "$sourceDirectory\_build\default\bin\erlang_ls.cmd" -Destination ".\erlang_ls.cmd" -Force
Move-Item -Path "$sourceDirectory\_build\dap\bin\els_dap" -Destination ".\els_dap" -Force
Move-Item -Path "$sourceDirectory\_build\dap\bin\els_dap.cmd" -Destination ".\els_dap.cmd" -Force

Remove-Item $sourceDirectory -Force -Recurse -ErrorAction SilentlyContinue