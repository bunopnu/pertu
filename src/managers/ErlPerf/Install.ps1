using module ..\..\utils\Path.psm1
using module ..\..\utils\Version.psm1

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args "max-au/erlperf"
 
# Create necessary folders for ErlPerf
$erlperfVersionPath = Get-PertuManagerVersionDirectory "erlperf" $version
Remove-Item $erlperfVersionPath -Force -Recurse -ErrorAction SilentlyContinue
[void](New-Item -ItemType Directory -Path $erlperfVersionPath -Force)

# Download the source code of ErlPerf
$sourceUrl = "https://github.com/max-au/erlperf/archive/refs/tags/$version.zip"
$sourceZip = "$erlperfVersionPath\source.zip"
Invoke-WebRequest -Uri $sourceUrl -OutFile $sourceZip

# Unzip the source code
Expand-Archive -Path $sourceZip -DestinationPath $erlperfVersionPath

# Compile ErlPerf
$sourceDirectory = Get-GitHubRepositoryDirectory "erlperf" "erlperf" $version
Set-Location $sourceDirectory

rebar3 as prod escriptize

# Clean up
Set-Location $erlperfVersionPath

Remove-Item -Path $sourceZip

Move-Item -Path (Join-Path -Path $sourceDirectory -ChildPath "_build\prod\bin\erlperf") -Destination ".\erlperf" -Force
Move-Item -Path (Join-Path -Path $sourceDirectory -ChildPath "_build\prod\bin\erlperf.cmd") -Destination ".\erlperf.cmd" -Force

Remove-Item $sourceDirectory -Force -Recurse -ErrorAction SilentlyContinue
