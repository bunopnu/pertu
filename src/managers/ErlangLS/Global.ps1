using module ..\..\utils\Action.psm1

# Find the specified version argument in the command-line arguments
$version = Find-VersionFromArgument $args "erlang-ls/erlang_ls"

# Add the specified version of ErlangLS to the environment
Copy-ManagerToBin "erlang-ls" $version
