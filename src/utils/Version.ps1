function Write-GitHubReleases($repo) {
  # Download latest release from GitHub
  $uri = "https://api.github.com/repos/$repo/releases"
  $releases = Invoke-RestMethod -Uri $uri -UseBasicParsing

  # Reverse array
  [array]::Reverse($releases)

  # Print versions
  foreach ($release in $releases) {
    Write-Host $release.tag_name
  }
}
