Import-Module ".\utils\Path.ps1"
Import-Module ".\utils\Version.ps1"

# Find the specified version argument in the command-line arguments
$version = Find-VersionArgument $args

# Create necessary folders for the rebar manager
$gleamVersionPath = Get-PertuManagerVersionDirectory "gleam" $version
Remove-Item $gleamVersionPath -Force -Recurse -ErrorAction SilentlyContinue
[void](New-Item -ItemType Directory -Path $gleamVersionPath -Force)

# Download the source code of Gleam
$sourceUrl = "https://github.com/gleam-lang/gleam/archive/refs/tags/$version.zip"
$sourceZip = "$gleamVersionPath\source.zip"
Invoke-WebRequest -Uri $sourceUrl -OutFile $sourceZip

# Unzip the source code
Expand-Archive -Path $sourceZip -DestinationPath $gleamVersionPath

# Compile Gleam
$sourceDirectory = (Get-GitHubRepositoryDirectory "gleam" "gleam" $version).Replace("gleam-v", "gleam-")
Set-Location $sourceDirectory
cargo build --release

# Clean up
Set-Location $gleamVersionPath

Remove-Item -Path $sourceZip
Move-Item -Path "$sourceDirectory\target\release\gleam.exe" -Destination ".\gleam.exe" -Force
Remove-Item $sourceDirectory -Force -Recurse -ErrorAction SilentlyContinue
