using module ..\..\utils\Action.psm1

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args "sile/efmt"

# Add the specified version of efmt to the environment
Copy-ManagerToBin "efmt" $version
