Import-Module ".\src\utils\Action.ps1"

# Find the specified version argument in the command-line arguments
$version = Find-VersionArgument $args

# Add the specified version of the rebar manager to the environment
Copy-ManagerToBin "rebar" $version
