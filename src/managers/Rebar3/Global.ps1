using module ..\..\utils\Action.psm1

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args "erlang/rebar3"

# Add the specified version of the rebar manager to the environment
Copy-ManagerToBin "rebar" $version
