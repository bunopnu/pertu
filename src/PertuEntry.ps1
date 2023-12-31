using module .\utils\Path.psm1

# Stop the script immediately if an error occurrs
$ErrorActionPreference = "Stop"

# Check command-line arguments
if ($args.Count -lt 1) {
  Write-Error "Please provide a manager to use Pertu!"
  Exit
}
elseif ($args.Count -lt 2) {
  Write-Error "Please provide an action to use Pertu!"
  Exit
}

# Get the Pertu bin directory and the user's environment path
$binDirectory = Get-PertuBinDirectory
$environmentPath = [Environment]::GetEnvironmentVariables("User").Path

# Create the necessary folders if they do not exist
[void](New-Item -ItemType Directory -Path $binDirectory -Force)

# Add .pertu/bin to the environment path if it is not already present
if (-Not ($environmentPath.Contains($binDirectory))) {
  $environmentPath += ";$binDirectory"
  [Environment]::SetEnvironmentVariable("Path", $environmentPath, [EnvironmentVariableTarget]::User)
}

# Get the manager and action from the command-line arguments
$manager = $args[0]
$action = $args[1]
$actionArgs = $args[2..$args.Length]

# Load the manager and action modules with specified arguments
$managerModulePath = "$PSScriptRoot\managers\$manager\$action.ps1"
Import-Module $managerModulePath -ArgumentList $actionArgs
