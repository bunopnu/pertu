Import-Module ".\src\utils\Path.ps1"

# Check command-line arguments
if ($args.Count -lt 1) {
  Write-Error "Please provide a manager to use Pertu!"
  Exit
}
elseif ($args.Count -lt 2) {
  Write-Error "Please provide an action to use Pertu!"
  Exit
}

# Get the home directory and environment path
$binDirectory = Get-PertuBin
$environmentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::User)

# Create necessary folders if it doesn't exist
[void](New-Item -ItemType Directory -Path $binDirectory -Force)

# Add .pertu/bin to the environment path if not already
if (-Not ($environmentPath.Contains($binDirectory))) {
  $environmentPath += ";$binDirectory"
  [Environment]::SetEnvironmentVariable("Path", $environmentPath, [EnvironmentVariableTarget]::User)
}

# Load manager and action
$manager = $args[0]
$action = $args[1]
$actionArgs = $args[2..$args.Length]

Import-Module ".\src\managers\$manager\$action.ps1" -ArgumentList $actionArgs
