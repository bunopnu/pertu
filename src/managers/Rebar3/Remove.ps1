using module ..\..\utils\Action.ps1

# Find the specified version argument in the command-line arguments
$version = Find-VersionArgument $args

# Remove the specified version of the Rebar3
Remove-ManagerVersion "rebar" $version @("rebar3", "rebar3.cmd", "rebar3.ps1")
