# Entra-ID-Identity-Management
# Managing Identities in Entra ID
An implementation of identity lifecycle management within Microsoft Entra ID, demonstrating a strategic shift from manual provisioning to automated PowerShell workflows via the Microsoft Graph SDK.

Objective: This project demonstrates the management of user identities within Microsoft Entra ID using both the Administrative Portal and the Microsoft Graph PowerShell SDK. The goal was to transition from manual entry to automated, scalable onboarding processes.

Manual Identity Provisioning
Actions Taken: I Manually created accounts for Edmund Reeve (HR) and Miranda Snider (Operations) via the Entra Admin Center.

User Type: Member (Standard internal employee).
Usage Location: Set to "United States."
Properties: Assigned Job Titles and Departments.

- Usage Location: You cannot assign Microsoft 365 licenses (Outlook, Teams) to a user unless a Usage Location is set. This is due to regional compliance and data laws.
- Manual Control for Sensitive Roles: Manual creation is often preferred for high-privilege roles or immediate one-off onboardings where manual verification of identity documents is required.
- Setting specific UsageLocation, Job Title, and Department is not just for bookkeeping. It is critical for Dynamic Groups. For example, by tagging Miranda as "Helpdesk Manager," she can be automatically added to security groups that grant access to ticketing systems via Attribute-Based Access Control (ABAC) also I can now create a rule that says "Any user in the HR department automatically gets access to the Payroll folder," saving IT hours of manual work.

PowerShell Automation
Actions Taken: In this lab i made use of the Powershell environment and Installed the Microsoft.Graph module.

- Scalability: While manual entry works for two users, it fails for 200 or a large number of users. Automation ensures that every user is created with the exact same security posture.

- Standardization: Using scripts prevents human error (typos in UPNs - User principal names or forgotten department tags), which can cause identification issued in a large directory.

Secure Connection & Scoped Permissions
Powershell Command: I connected the tenant using: Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All"

- Principle of Least Privilege (PoLP): We did not sign in with global permissions. We requested only the specific scopes (User.ReadWrite.All) needed for the task. This limits the "blast radius" if the administrative session were ever compromised.

User Creation (Cody Godinez)
PowerShell Script Logic:

$PWProfile = @{
      Password = "______"; 
      ForceChangePasswordNextSignIn = $false
}

New-MgUser -DisplayName "Cody Godinez" `
      -GivenName "Cody" -Surname "Godinez" `
      -MailNickname "cgodinez" `
      -UsageLocation "US" `
      -UserPrincipalName "cgodinez@tenant.onmicrosoft.com" `
      -PasswordProfile $PWProfile -AccountEnabled `
      -Department "Sales" -JobTitle "Sales Rep"

- Password Profile Management: In this lab, I set this to $false for testing, but in a real corporate environment, I would set this to $true. This ensures that even the Admin who created the account doesn't know the user's final password, maintaining Zero Trust principle.
- UsageLocation: This is mandatory for assigning licenses later. Without this attribute, Entra ID cannot legally assign service licenses (like M365) due to regional compliance laws.
- AccountEnabled: By setting this to $true during creation, the user is productive from Minute 1 of their first day.

