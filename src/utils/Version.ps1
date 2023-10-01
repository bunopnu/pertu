function Write-GitHubReleases($repo) {
  # Download releases from GitHub
  $uri = "https://api.github.com/repos/$repo/releases"
  $releases = Invoke-RestMethod -Uri $uri -UseBasicParsing

  # Reverse array
  [array]::Reverse($releases)

  # Print versions
  foreach ($release in $releases) {
    Write-Host $release.tag_name
  }
}

function Get-VersionFile($manager) {
  return "$env:USERPROFILE\.pertu\bin\$manager-version.txt"
}

function Get-VersionContent($manager) {
  try {
    $versionFile = Get-VersionFile $manager
    return Get-Content -Path $versionFile -ErrorAction Stop
  }
  catch {
    return $null
  }
}

function Find-VersionArgument($arguments) {
  $version = $arguments[0]

  if ($null -eq $version) {
    Write-Error "Please provide a version to run action"
    Exit
  }

  return $version
}