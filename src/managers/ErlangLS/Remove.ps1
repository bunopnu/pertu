using module ..\..\utils\Action.psm1

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args "erlang-ls/erlang_ls"

# Remove the specified version of the ErlangLS
Remove-ManagerVersion "erlang-ls" $version @("erlang_ls", "erlang_ls.cmd", "els_dap", "els_dap.cmd")
