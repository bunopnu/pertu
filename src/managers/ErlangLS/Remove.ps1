Import-Module ".\src\utils\Action.ps1"

# Find the specified version argument in the command-line arguments
$version = Find-VersionArgument $args

# Remove the specified version of the ErlangLS
Remove-ManagerVersion "erlang-ls" $version @("erlang_ls", "erlang_ls.cmd", "els_dap", "els_dap.cmd")
