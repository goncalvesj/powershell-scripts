#
# Script to add a bunch of service principals that belong to azure web apps with managed service identity to an Azure AD group
# The group can then be used in a key vault to grant access to all web apps in one go
#


#Log in to Azure
#Login-AzureRmAccount

#Creates Azure AD Group
$Group = New-AzureADGroup -Description "Service Principals" -DisplayName "App Service Principals" -MailEnabled $false -SecurityEnabled $true -MailNickName "AppServicePrincipals"

#Gets All Service Principals that contain "dev" in their name
$List = Get-AzureRmADServicePrincipal | Where-Object { $_.DisplayName -match "dev" }

$List | ForEach-Object { 

	Write-Output $_.DisplayName

	#Add Service Principal to AD Group
	Add-AzureADGroupMember -ObjectId $Group.ObjectId -RefObjectId $_.Id

}