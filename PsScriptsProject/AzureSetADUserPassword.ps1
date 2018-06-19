#
# Script to create a password and apply it to an Azure AD user
#

Connect-AzureAD

$password = ConvertTo-SecureString "XXXXXXXXXX" -AsPlainText -Force

Set-AzureADUserPassword -ObjectId "XXXXXX" -Password $password