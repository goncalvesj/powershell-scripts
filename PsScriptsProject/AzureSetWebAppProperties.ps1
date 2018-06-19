#
# Script to set/modify azure web apps application settings
#

#Login-AzureRmAccount 
#Select-AzureRmSubscription -SubscriptionName "Name"

$ResourceGroupName = "Name"

#Disables ARR Affinity and set the web app to be Always On
$WebAppPropertiesObject = @{
    "clientAffinityEnabled" = $false    
    "siteConfig" = @{
            "AlwaysOn" = $true
            }
}

$WebAppResourceType = 'microsoft.web/sites'
$WebApps = @("WebApp1", "WebApp2", "WebApp3", "WebApp4", "WebApp5")

ForEach ($WebAppName In $WebApps) 
{

    $webAppResource = Get-AzureRmResource -ResourceType $WebAppResourceType -ResourceGroupName $ResourceGroupName -ResourceName $WebAppName
    $webAppResource | Set-AzureRmResource -PropertyObject $WebAppPropertiesObject -Force
}