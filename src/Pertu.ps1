# Testing...

$repo = "erlang/rebar3"
$releases = "https://api.github.com/repos/$repo/releases"

Write-Host "Releases from $repo"

$releases = Invoke-RestMethod -Uri $releases -UseBasicParsing

foreach ($release in $releases) {
  Write-Host $release.tag_name
}
