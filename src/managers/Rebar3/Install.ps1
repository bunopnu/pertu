using module ..\..\utils\Path.psm1
using module ..\..\utils\Version.psm1

$githubRepository = "erlang/rebar3"

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args  $githubRepository

# Create necessary folders for the rebar manager
$rebarVersionPath = Get-PertuManagerVersionDirectory "rebar" $version
Remove-Item $rebarVersionPath -Force -Recurse -ErrorAction SilentlyContinue
[void](New-Item -ItemType Directory -Path $rebarVersionPath -Force)

# Download the source code of rebar3
$sourceUrl = Get-GitHubDownloadLink $githubRepository $version
$sourceZip = "$rebarVersionPath\source.zip"
Invoke-WebRequest -Uri $sourceUrl -OutFile $sourceZip

# Unzip the source code
Expand-Archive -Path $sourceZip -DestinationPath $rebarVersionPath

# Compile rebar3
$sourceDirectory = Get-GitHubRepositoryDirectory "rebar" $version
Set-Location $sourceDirectory
powershell .\bootstrap.ps1

# Clean up
Set-Location $rebarVersionPath

Remove-Item -Path $sourceZip

Move-Item -Path "$sourceDirectory\rebar3" -Destination ".\rebar3" -Force
Move-Item -Path "$sourceDirectory\rebar3.cmd" -Destination ".\rebar3.cmd" -Force
Move-Item -Path "$sourceDirectory\rebar3.ps1" -Destination ".\rebar3.ps1" -Force

Remove-Item $sourceDirectory -Force -Recurse -ErrorAction SilentlyContinue
