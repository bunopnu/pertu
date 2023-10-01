# Function to get the Pertu bin directory
function Get-PertuBinDirectory() {
  return "$env:USERPROFILE\.pertu\bin"
}

# Function to get the directory for a Pertu manager
function Get-PertuManagerDirectory($manager) {
  return "$env:USERPROFILE\.pertu\$manager"
}

# Function to get the directory for a specific version of a Pertu manager
function Get-PertuManagerVersionDirectory($manager, $version) {
  return "$env:USERPROFILE\.pertu\$manager\$version"
}

# Function to get the directory for a specific GitHub repository version
function Get-GitHubRepositoryDirectory($manager, $repository, $version) {
  return "$env:USERPROFILE\.pertu\$manager\$version\$repository-$version"
}
