#
# Removes all public ip addresses from network interfaces.
#

#Login-AzureRmAccount -Subscription "Name"

$NetworkInterfaces = Get-AzureRmNetworkInterface -ResourceGroupName "Name"

foreach($item in $NetworkInterfaces)
{
    Write-Output $item.Name

    if ($item.IpConfigurations.PublicIpAddress.Id)
    {
		$item.IpConfigurations.PublicIpAddress.id = ""

		$item | Set-AzureRmNetworkInterface

		Write-Output "Public Ip Removed"
    }    
}