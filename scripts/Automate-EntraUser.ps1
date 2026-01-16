<#
.SYNOPSIS
    Automates the creation of Sales Department users in Entra ID.
    
.DESCRIPTION
    This script uses the Microsoft Graph SDK to provision users. 
    It ensures all users have a UsageLocation set to enable M365 licensing.
#>

# Connect with limited scope to follow security best practices
Connect-MgGraph -Scopes "User.ReadWrite.All"

# Define the password object
$PWProfile = @{
      Password = "ComplexPassword123!";
      ForceChangePasswordNextSignIn = $true # Security: Force user to own their credentials
}

# Execute creation with standardized attributes
New-MgUser -DisplayName "Cody Godinez" `
      -GivenName "Cody" -Surname "Godinez" `
      -MailNickname "cgodinez" `
      -UsageLocation "US" `
      -UserPrincipalName "cgodinez@YOURTENANT.onmicrosoft.com" `
      -PasswordProfile $PWProfile -AccountEnabled `
      -Department "Sales" -JobTitle "Sales Rep"

# Verification step
Get-MgUser -UserId "cgodinez@YOURTENANT.onmicrosoft.com"
