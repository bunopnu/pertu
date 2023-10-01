using module ..\..\utils\Path.ps1
using module ..\..\utils\Version.ps1

# Find the specified version argument in the command-line arguments
$version = Find-VersionArgument $args

# Check if `latest` is passed, check set it to actual latest version
if ($version -eq "latest") {
  $version = (Get-GitHubReleases "erlang/rebar3")[0]

  Write-Host "Latest version is $version, installing..."
}

# Create necessary folders for the rebar manager
$rebarVersionPath = Get-PertuManagerVersionDirectory "rebar" $version
Remove-Item $rebarVersionPath -Force -Recurse -ErrorAction SilentlyContinue
[void](New-Item -ItemType Directory -Path $rebarVersionPath -Force)

# Download the source code of rebar3
$sourceUrl = "https://github.com/erlang/rebar3/archive/refs/tags/$version.zip"
$sourceZip = "$rebarVersionPath\source.zip"
Invoke-WebRequest -Uri $sourceUrl -OutFile $sourceZip

# Unzip the source code
Expand-Archive -Path $sourceZip -DestinationPath $rebarVersionPath

# Compile rebar3
$sourceDirectory = Get-GitHubRepositoryDirectory "rebar" "rebar3" $version
Set-Location $sourceDirectory
powershell .\bootstrap.ps1

# Clean up
Set-Location $rebarVersionPath

Remove-Item -Path $sourceZip

Move-Item -Path "$sourceDirectory\rebar3" -Destination ".\rebar3" -Force
Move-Item -Path "$sourceDirectory\rebar3.cmd" -Destination ".\rebar3.cmd" -Force
Move-Item -Path "$sourceDirectory\rebar3.ps1" -Destination ".\rebar3.ps1" -Force

Remove-Item $sourceDirectory -Force -Recurse -ErrorAction SilentlyContinue
