Import-Module ".\src\utils\Path.ps1"
Import-Module ".\src\utils\Version.ps1"

# Check if version given
$version = Find-VersionArgument $args
$currentVersion = Get-VersionContent "rebar"

$rebarPath = Get-PertuManagerVersionDir "rebar" $version
Remove-Item $rebarPath -Force -Recurse -ErrorAction SilentlyContinue

# Also remove from .pertu/bin
if ($currentVersion -eq $version) {
  $binDirectory = Get-PertuBin
  $versionFile = Get-VersionFile "rebar"

  Remove-Item "$binDirectory\rebar3" -Force
  Remove-Item "$binDirectory\rebar3.ps1" -Force
  Remove-Item "$binDirectory\rebar3.cmd" -Force
  Remove-Item $versionFile -Force
}
