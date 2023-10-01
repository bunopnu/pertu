using module ..\..\utils\Action.ps1

# Find the specified version argument in the command-line arguments
$version = Find-VersionArgument $args

# Remove the specified version of the Gleam
Remove-ManagerVersion "gleam" $version @("gleam.exe")
