Import-Module ".\src\utils\Path.ps1"
Import-Module ".\src\utils\Version.ps1"

# Copy files to .pertu/bin directory
function Copy-ManagerToBin($manager, $version) {
  $managerVersionDirectory = Get-PertuManagerVersionDirectory $manager $version
  $binDirectory = Get-PertuBinDirectory

  Get-ChildItem -Path $managerVersionDirectory -File | Copy-Item -Destination $binDirectory -Force

  $versionFilePath = Get-VersionFilePath $manager
  [void](New-Item -ItemType File -Path $versionFilePath -Value $version -Force)
}

# Remove a specific version of a manager
function Remove-ManagerVersion($manager, $version, $extras) {
  $currentVersion = Get-VersionFileContent $manager

  $managerVersionDirectory = Get-PertuManagerVersionDirectory $manager $version
  Remove-Item $managerVersionDirectory -Force -Recurse -ErrorAction SilentlyContinue

  # Remove from .pertu/bin directory if it's the current version
  if ($currentVersion -eq $version) {
    $binDirectory = Get-PertuBinDirectory
    $versionFilePath = Get-VersionFilePath $manager

    foreach ($extra in $extras) {
      Remove-Item "$binDirectory\$extra" -Force
    }

    Remove-Item $versionFilePath -Force
  }
}
