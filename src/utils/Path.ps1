function Get-PertuBin() {
  return "$env:USERPROFILE\.pertu\bin"
}

function Get-PertuManagerDir($manager) {
  return "$env:USERPROFILE\.pertu\$manager"
}

function Get-PertuManagerVersionDir($manager, $version) {
  return "$env:USERPROFILE\.pertu\$manager\$version"
}

function Get-RebarSourceDir($version) {
  return "$env:USERPROFILE\.pertu\rebar\$version\rebar3-$version"
}
