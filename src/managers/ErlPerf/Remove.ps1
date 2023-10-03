using module ..\..\utils\Action.psm1

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args "max-au/erlperf"

# Remove the specified version of the ErlPerf
Remove-ManagerVersion "erlperf" $version @("erlperf", "erlperf.cmd")
