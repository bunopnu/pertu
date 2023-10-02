using module ..\..\utils\Action.psm1

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args "gleam-lang/gleam"

# Remove the specified version of the Gleam
Remove-ManagerVersion "gleam" $version @("gleam.exe")
