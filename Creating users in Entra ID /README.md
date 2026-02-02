# Creating Users in Entra ID

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

To conclude the lab, I performed a directory audit to verify the successful creation of all three identities.

PowerShell script: Get-MgUser

Result: The output confirmed that Edmund, Miranda, and Cody were all successfully provisioned as Member users, each correctly associated with their respective DisplayName, UserPrincipalName, and Department.

# On the next lab, it focuses on Assigning Administrative roles in Entra ID

Managing privileged access within an organization by assigning specific administrative roles to users in Microsoft Entra ID.

Walkthrough: The primary objective was to ensure that specific users were granted the appropriate level of access required for their job functions, following the principle of least privilege where applicable.

1. The process began in the Microsoft Entra admin center. To manage permissions, I navigated to the Roles & admins section in the sidebar. This area serves as the central hub for viewing all built-in and custom directory roles.
2. The first requirement was to appoint a Global administrator to manage the entire tenant.

- I utilized the search bar to locate the Global administrator role.
- After selecting the role name, I entered the assignment pane and selected + Add assignments.
- I identified Allan Deyoung from the member list and successfully added him to the role.

3. The next task involved the User administrator role, which is essential for handling password resets and managing user accounts.

- While the initial scenario table listed Joni Siraman for this role, Joni Siraman did not appear in the system, so I assigned the task to Edmund Reeve instead. In a real‑world scenario, verifying the correct identity is essential.
- I searched for the role, selected + Add assignments, and assigned it to Edmund Reeve to fulfill the technical requirement.

4. For users who only need to manage password resets without full user management capabilities, I utilized the Helpdesk administrator role.\

<img width="1426" height="785" alt="image" src="https://github.com/user-attachments/assets/9cd669cc-e3d6-4532-b88c-225e700b754e" />
<img width="1428" height="783" alt="image" src="https://github.com/user-attachments/assets/d016b447-e828-4849-bf01-8937f0d57569" />
<img width="1427" height="784" alt="image" src="https://github.com/user-attachments/assets/a8d6f3da-c89c-4cf0-8e9b-c2b54dc4e1ea" />
<img width="1429" height="786" alt="image" src="https://github.com/user-attachments/assets/55e68a41-fdc9-409b-bd69-cd0d60284a14" />

<img width="1424" height="785" alt="image" src="https://github.com/user-attachments/assets/f69a4864-00f7-4431-8427-92dc45e14949" />
<img width="1424" height="783" alt="image" src="https://github.com/user-attachments/assets/6016dd01-d335-451e-bc14-e1fe36ae2f0f" />
<img width="1429" height="786" alt="image" src="https://github.com/user-attachments/assets/5b54da2d-eee1-4404-aed7-87d8f9bf8abf" />
<img width="1430" height="783" alt="image" src="https://github.com/user-attachments/assets/31aaf816-e88f-43c5-95b1-fef885740355" />

<img width="986" height="513" alt="image" src="https://github.com/user-attachments/assets/42194d42-17b4-4ec2-a89e-31a645a4babf" />
<img width="982" height="515" alt="image" src="https://github.com/user-attachments/assets/2f0d99f9-7369-455c-9f2b-61673fa5cd1f" />
<img width="1021" height="644" alt="image" src="https://github.com/user-attachments/assets/285f9f11-7677-4789-a5bc-52d63069963d" />
<img width="986" height="513" alt="image" src="https://github.com/user-attachments/assets/71e06c19-3a85-4ae7-996b-dc83c82d94f4" />
<img width="984" height="517" alt="image" src="https://github.com/user-attachments/assets/9a92c1ee-7463-43bf-80fe-67b592178d31" />
<img width="985" height="514" alt="image" src="https://github.com/user-attachments/assets/e14e3e8d-f3bc-4b32-a547-9d8e4ddce291" />













- Following the same workflow, I searched for this role and added Miranda Snider
- The assignment was finalized by clicking Add.

