# Connect to Azure AD
$TenantId = "xxxxx"
Connect-AzureAD -TenantId $TenantId

# Create New User
$NewUserEmail = "NewUser@xxxxx.onmicrosoft.com"
$NewUserName = "NewUser"

$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "xxxx"
New-AzureADUser -DisplayName $NewUserName -PasswordProfile $PasswordProfile -UserPrincipalName $NewUserEmail -AccountEnabled $true -MailNickName $NewUserName

# Set New User as Global Admin
$roleMember = Get-AzureADUser -ObjectId $NewUserEmail
$role = Get-AzureADDirectoryRole | Where-Object {$_.displayName -eq 'Company Administrator'}
Add-AzureADDirectoryRoleMember -ObjectId $role.ObjectId -RefObjectId $roleMember.ObjectId

# Log in with new User
Connect-AzureAD -TenantId $TenantId -AccountId $NewUserEmail

# Get Enterprise App Object Id
$AzDevOps = Get-AzureADServicePrincipal | Where-Object {$_.displayName -eq 'Azure DevOps'}

# Remove Enterprise App
Remove-AzureADServicePrincipal -ObjectId $AzDevOps.ObjectId

# If just removing the Azure DevOps enterprise app is not enough, run this:
# Some errors like this will appear: "Specified App Principal ID is Microsoft Internal." but it'll get the job done
Get-AzureADServicePrincipal | Select-Object -ExpandProperty ObjectId | ForEach-Object { 
    Remove-AzureADServicePrincipal -ObjectId $_
}

# Now go the Azure Portal -> Azure AD -> Delete NewUser -> Delete tenant
