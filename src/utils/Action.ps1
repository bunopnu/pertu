Import-Module ".\src\utils\Path.ps1"
Import-Module ".\src\utils\Version.ps1"

# Copy files to .pertu/bin
function Add-Global($manager, $version) {
  $buildDirectory = Get-PertuManagerVersionDir $manager $version
  $binDirectory = Get-PertuBin

  Get-ChildItem -Path "$buildDirectory" -File | Copy-Item -Destination "$binDirectory" -Force

  $versionFile = Get-VersionFile $manager
  [void](New-Item -ItemType File -Path $versionFile -Value $version -Force)
}

# Remove given version
function Remove-Version($manager, $version, $extras) {
  $currentVersion = Get-VersionContent $manager

  $rebarPath = Get-PertuManagerVersionDir $manager $version
  Remove-Item $rebarPath -Force -Recurse -ErrorAction SilentlyContinue

  # Also remove from .pertu/bin
  if ($currentVersion -eq $version) {
    $binDirectory = Get-PertuBin
    $versionFile = Get-VersionFile $manager

    foreach ($extra in $extras) {
      Remove-Item "$binDirectory\$extra" -Force
    }

    Remove-Item $versionFile -Force
  }
}