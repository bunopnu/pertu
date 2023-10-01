Import-Module ".\src\utils\Path.ps1"
Import-Module ".\src\utils\Version.ps1"

# Check if version given
$version = Find-VersionArgument $args

# Move to rebar3 source
$sourceDirectory = Get-PertuManagerVersionDir "rebar" $version
$binDirectory = Get-PertuBin

Copy-Item -Path "$sourceDirectory\rebar3" -Destination "$binDirectory\rebar3" -Force
Copy-Item -Path "$sourceDirectory\rebar3.cmd" -Destination "$binDirectory\rebar3.cmd" -Force
Copy-Item -Path "$sourceDirectory\rebar3.ps1" -Destination "$binDirectory\rebar3.ps1" -Force

$versionFile = Get-VersionFile "rebar"
[void](New-Item -ItemType File -Path $versionFile -Value $version -Force)
