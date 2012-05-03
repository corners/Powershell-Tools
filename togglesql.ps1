# PowerShell cmdlet to check a service's status
# ` is the Escape character
# "SQLBrowser", 
$services = "MSSQL`$SQLEXPRESS", "MSSQL`$SQL2008", "SQLWriter"
$servicePrior = get-Service $services[1]
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

