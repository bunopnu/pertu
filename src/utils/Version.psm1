# Function to retrieve GitHub releases for a repository and return them
function Get-GitHubReleases($repository) {
  $uri = "https://api.github.com/repos/$repository/releases"
  $releases = Invoke-RestMethod -Uri $uri -UseBasicParsing
  
  return $releases.tag_name
}

# Function to retrieve GitHub released for a repository and write them to host
function Write-GitHubReleases($repository) {
  $releases = Get-GitHubReleases($repository)

  # Reverse the array
  [array]::Reverse($releases)

  Write-Host $($releases -join "`n")
}

# Function to get the version file path for a manager
function Get-VersionFilePath($manager) {
  return "$env:LocalAppdata\.pertu\bin\$manager-version.txt"
}

# Function to retrieve the content of the version file for a manager
function Get-VersionFileContent($manager) {
  try {
    $versionFile = Get-VersionFilePath $manager
    return Get-Content -Path $versionFile
  }
  catch {
    return $null
  }
}

# Function to find and return the version argument from a list of arguments
function Find-VersionFromArgument($arguments, $repository) {
  $releases = Get-GitHubReleases $repository
  $version = $arguments[0]

  if ($null -eq $version) {
    Write-Error "Please provide a version to run the action"
    Exit
  }
  elseif ($version -eq "latest") {
    $version = $releases[0]
    Write-Host "Latest version is $version"
  }

  if (!$releases.Contains($version)) {
    Write-Error "Provided version $version does not exist. To list all the available versions, please use list-all sub-command."
  }

  return $version
}

# Function to write a list of available versions for a manager
function Write-AvailableVersions($manager) {
  $currentVersion = Get-VersionFileContent $manager
  $managerPath = Get-PertuManagerDirectory $manager

  $versions = Get-ChildItem -Path $managerPath -Directory

  foreach ($version in $versions) {
    if ($currentVersion -eq $version) {
      Write-Host "* $version"
    }
    else {
      Write-Host "  $version"
    }
  }
}
