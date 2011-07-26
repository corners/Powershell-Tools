# PowerShell cmdlet to check a service's status
$services = "OracleServiceORCL", "OracleOraDb10g_home1TNSListener", "OracleOraDb10g_home1iSQL*Plus", "OracleDBConsoleorcl"
$servicePrior = get-Service $services[0]
$services[0] + " is currently " + $servicePrior.status
$turnOff = $servicePrior.status -eq  "Running"

foreach ($serviceName in $services)
{
	$actualStatus = ((get-Service $serviceName).status -eq "Running")
	if ($turnOff)
	{
		if ($actualStatus)
		{
			"Stopping " + $serviceName
			stop-service $serviceName -Force
			$action = "stopped"
		}
	}
	else
	{
		if (!$actualStatus)
		{
			"Starting " + $serviceName
			start-service $serviceName
			$action = "started"
		}
	}
}


"The server is now: " + $action
