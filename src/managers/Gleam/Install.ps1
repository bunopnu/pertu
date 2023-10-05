using module ..\..\utils\Path.psm1
using module ..\..\utils\Version.psm1

$githubRepository = "gleam-lang/gleam"

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args $githubRepository

# Create necessary folders for the gleam manager
$gleamVersionPath = Get-PertuManagerVersionDirectory "gleam" $version
Remove-Item $gleamVersionPath -Force -Recurse -ErrorAction SilentlyContinue
[void](New-Item -ItemType Directory -Path $gleamVersionPath -Force)

# Download the source code of Gleam
$sourceUrl = Get-GitHubDownloadLink $githubRepository $version
$sourceZip = "$gleamVersionPath\source.zip"
Invoke-WebRequest -Uri $sourceUrl -OutFile $sourceZip

# Unzip the source code
Expand-Archive -Path $sourceZip -DestinationPath $gleamVersionPath

# Compile Gleam
$sourceDirectory = Get-GitHubRepositoryDirectory "gleam" $version
Set-Location $sourceDirectory
cargo build --release

# Clean up
Set-Location $gleamVersionPath

Remove-Item -Path $sourceZip
Move-Item -Path "$sourceDirectory\target\release\gleam.exe" -Destination ".\gleam.exe" -Force
Remove-Item $sourceDirectory -Force -Recurse -ErrorAction SilentlyContinue
