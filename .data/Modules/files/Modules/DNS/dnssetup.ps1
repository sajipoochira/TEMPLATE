# Import the Server Manager module
Import-Module ServerManager

# Check if the DNS Server role is already installed
$DnsServerRole = Get-WindowsFeature | Where-Object { $_.Name -eq "DNS" }

# If the DNS Server role is not installed, install it
if (!$DnsServerRole.Installed) {
    Install-WindowsFeature -Name DNS -IncludeManagementTools
}


###################################################################

Import-Module DnsServer

# Define the forwarder IP address
$ForwarderIP = "168.63.129.16"


$ForwardingDomains = @("azure.net", "azure-automation.net", "azurewebsites.net", "monitor.azure.com", "opinsights.azure.com", "windows.net")

foreach ($ForwardingDomain in $ForwardingDomains) {
    <# $currentItemName is the current item #>

    
# Create the conditional forwarder
Add-DnsServerConditionalForwarderZone -Name $ForwardingDomain -MasterServers $ForwarderIP -PassThru

}


Add-DnsServerForwarder -IPAddress 8.8.8.8 -PassThru



