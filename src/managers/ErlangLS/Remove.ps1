Import-Module ".\src\utils\Action.ps1"

$version = Find-VersionArgument $args
Remove-Version "erlang-ls" $version @("erlang_ls", "erlang_ls.cmd", "els_dap", "els_dap.cmd")
