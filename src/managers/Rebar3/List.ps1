Import-Module ".\src\utils\Path.ps1"
Import-Module ".\src\utils\Version.ps1"

$currentVersion = Get-VersionContent "rebar"
$managerPath = Get-PertuManagerDir "rebar"

$versions = Get-ChildItem -Path $managerPath -Directory

foreach ($version in $versions) {
  if ($currentVersion -eq $version) {
    Write-Host "* $version"
  }
  else {
    Write-Host "  $version"
  }
}
