using module ..\..\utils\Path.psm1
using module ..\..\utils\Version.psm1

$githubRepository = "sile/efmt"

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args $githubRepository
 
# Create necessary folders for efmt
$efmtVersionPath = Get-PertuManagerVersionDirectory "efmt" $version
Remove-Item $efmtVersionPath -Force -Recurse -ErrorAction SilentlyContinue
[void](New-Item -ItemType Directory -Path $efmtVersionPath -Force)

# Download the source code of efmt
$sourceUrl = Get-GitHubDownloadLink $githubRepository $version
$sourceZip = "$efmtVersionPath\source.zip"
Invoke-WebRequest -Uri $sourceUrl -OutFile $sourceZip

# Unzip the source code
Expand-Archive -Path $sourceZip -DestinationPath $efmtVersionPath

# Compile efmt
$sourceDirectory = Get-GitHubRepositoryDirectory "efmt" $version
Set-Location $sourceDirectory

cargo build --release

# Clean up
Set-Location $efmtVersionPath

Remove-Item -Path $sourceZip
Move-Item -Path "$sourceDirectory\target\release\efmt.exe" -Destination ".\efmt.exe" -Force
Remove-Item $sourceDirectory -Force -Recurse -ErrorAction SilentlyContinue
