using module ..\..\utils\Path.psm1
using module ..\..\utils\Version.psm1

$githubRepository = "max-au/erlperf"

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args $githubRepository
 
# Create necessary folders for ErlPerf
$erlperfVersionPath = Get-PertuManagerVersionDirectory "erlperf" $version
Remove-Item $erlperfVersionPath -Force -Recurse -ErrorAction SilentlyContinue
[void](New-Item -ItemType Directory -Path $erlperfVersionPath -Force)

# Download the source code of ErlPerf
$sourceUrl = Get-GitHubDownloadLink $githubRepository $version
$sourceZip = "$erlperfVersionPath\source.zip"
Invoke-WebRequest -Uri $sourceUrl -OutFile $sourceZip

# Unzip the source code
Expand-Archive -Path $sourceZip -DestinationPath $erlperfVersionPath

# Compile ErlPerf
$sourceDirectory = Get-GitHubRepositoryDirectory "erlperf" $version
Set-Location $sourceDirectory

rebar3 as prod escriptize

# Clean up
Set-Location $erlperfVersionPath

Remove-Item -Path $sourceZip

Move-Item -Path (Join-Path -Path $sourceDirectory -ChildPath "_build\prod\bin\erlperf") -Destination ".\erlperf" -Force
Move-Item -Path (Join-Path -Path $sourceDirectory -ChildPath "_build\prod\bin\erlperf.cmd") -Destination ".\erlperf.cmd" -Force

Remove-Item $sourceDirectory -Force -Recurse -ErrorAction SilentlyContinue
