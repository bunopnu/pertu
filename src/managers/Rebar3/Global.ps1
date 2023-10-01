Import-Module ".\src\utils\Action.ps1"

$version = Find-VersionArgument $args
Add-Global "rebar" $version
