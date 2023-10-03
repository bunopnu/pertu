using module ..\..\utils\Action.psm1

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args "max-au/erlperf"

# Add the specified version of ErlPerf to the environment
Copy-ManagerToBin "erlperf" $version
