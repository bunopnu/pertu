using module ..\..\utils\Action.ps1

# Find the specified version argument in the command-line arguments
$version = Find-VersionArgument $args

# Add the specified version of ErlangLS to the environment
Copy-ManagerToBin "erlang-ls" $version
