using module ..\..\utils\Action.psm1

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args "gleam-lang/gleam"

# Add the specified version of the gleam manager to the environment
Copy-ManagerToBin "gleam" $version
