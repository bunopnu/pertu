Import-Module ".\src\utils\Path.ps1"
Import-Module ".\src\utils\Version.ps1"

# Check if version given
$version = Find-VersionArgument $args

# Create necessary folders
$rebarPath = Get-PertuManagerVersionDir "rebar" $version
Remove-Item $rebarPath -Force -Recurse -ErrorAction SilentlyContinue
[void](New-Item -ItemType Directory -Path $rebarPath -Force)

# Download source code
$sourceUrl = "https://github.com/erlang/rebar3/archive/refs/tags/$version.zip"
$sourceZip = "$rebarPath\source.zip"
Invoke-WebRequest -Uri $sourceUrl -OutFile $sourceZip

# Unzip source code
Expand-Archive $sourceZip -DestinationPath $rebarPath

# Compile rebar3
$sourceDirectory = Get-RebarSourceDir $version
Set-Location $sourceDirectory
powershell .\bootstrap.ps1

# Clean up
Set-Location $rebarPath

Remove-Item -Path $sourceZip

Move-Item -Path "$sourceDirectory\rebar3" -Destination ".\rebar3" -Force
Move-Item -Path "$sourceDirectory\rebar3.cmd" -Destination ".\rebar3.cmd" -Force
Move-Item -Path "$sourceDirectory\rebar3.ps1" -Destination ".\rebar3.ps1" -Force

Remove-Item $sourceDirectory -Force -Recurse -ErrorAction SilentlyContinue
