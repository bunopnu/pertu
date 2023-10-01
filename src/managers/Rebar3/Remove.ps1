Import-Module ".\src\utils\Action.ps1"

$version = Find-VersionArgument $args
Remove-Version "rebar" $version @("rebar3", "rebar3.cmd", "rebar3.ps1")
