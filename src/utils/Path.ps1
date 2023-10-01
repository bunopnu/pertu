function Get-PertuBin() {
  return "$env:USERPROFILE\.pertu\bin"
}

function Get-PertuManagerDir($manager) {
  return "$env:USERPROFILE\.pertu\$manager"
}

function Get-PertuManagerVersionDir($manager, $version) {
  return "$env:USERPROFILE\.pertu\$manager\$version"
}

function Get-GitHubDir($manager, $repository, $version) {
  return "$env:USERPROFILE\.pertu\$manager\$version\$repository-$version"
}

