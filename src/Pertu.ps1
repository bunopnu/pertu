if ($args.Count -lt 1) {
  Write-Error "Please provide a manager to use Pertu!"
  Exit
}
elseif ($args.Count -lt 2) {
  Write-Error "Please provide an action to use Pertu!"
  Exit
}

try {
  $manager = $args[0]
  $action = $args[1]
  $actionArgs = $args[2..$args.Length]

  Import-Module ".\src\managers\$manager\$action.ps1" -ArgumentList $actionArgs -ErrorAction Stop
}
catch {
  Write-Error "Given manager/action doesn't exist"
}
