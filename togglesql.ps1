# PowerShell cmdlet to check a service's status
# ` is the Escape character
# "SQLBrowser", 
$services = "msftesql`$SQL2005", "MsDtsServer", "SQLWriter", "MSSQL`$SQL2005"
$servicePrior = get-Service $services[$services.length-1]
$services[0] + " is currently " + $servicePrior.status

foreach ($serviceName in $services)
{
	if ($servicePrior.status -eq  "Running")
	{
		"Stopping " + $serviceName
		stop-service $serviceName -Force
		$action = "stopped"
	}
	else
	{
		"Starting " + $serviceName
		start-service $serviceName
		$action = "started"
	}
}

"The server is now: " + $action
