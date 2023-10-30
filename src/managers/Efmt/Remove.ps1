using module ..\..\utils\Action.psm1

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args "sile/efmt"

# Remove the specified version of the efmt
Remove-ManagerVersion "efmt" $version @("efmt.exe")
