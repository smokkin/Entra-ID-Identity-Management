# L1Ex2: Synchronizing Identities using Microsoft Entra Connect - Security Lab

## Overview
This exercise demonstrates the configuration and security hardening of Microsoft Entra Connect for synchronizing on-premises Active Directory (AD) identities with Microsoft Entra ID (formerly Azure AD). The lab focuses on establishing a secure hybrid identity infrastructure with proper authentication and directory synchronization.

---

## Table of Contents
1. [Exercise Objectives](#exercise-objectives)
2. [Security Tasks Performed](#security-tasks-performed)
3. [Phase 1: Entra Connect Installation & Configuration](#phase-1-entra-connect-installation--configuration)
4. [Phase 2: Synchronization Verification & Security Hardening](#phase-2-synchronization-verification--security-hardening)
5. [Key Security Findings & Recommendations](#key-security-findings--recommendations)
6. [Evidence & Screenshots](#evidence--screenshots)

---

## Exercise Objectives

- **Establish Hybrid Identity**: Connect on-premises Active Directory to Microsoft Entra ID for seamless identity synchronization
- **Configure Secure Authentication**: Implement password hash synchronization (PHS) as a secure authentication method
- **Validate Synchronization**: Verify successful synchronization of users, groups, and organizational units
- **Apply Security Hardening**: Enforce security best practices for Entra Connect configuration and access controls
- **Monitor Identity Health**: Ensure proper logging, auditing, and health monitoring of the synchronization process

---

## Security Tasks Performed

### Task 1: Microsoft Entra Connect Installation & Initial Setup
**Objective**: Deploy Entra Connect with secure configuration defaults

**Steps Completed**:
- Downloaded and installed Microsoft Entra Connect on a dedicated server
- Selected "Customize synchronization settings" for granular control
- Configured SQL Server database backend for identity data storage
- Established secure connection parameters and connectivity verification

**Security Considerations**:
- ✅ Used dedicated server for Entra Connect deployment (not installed on domain controller)
- ✅ Configured local admin account with strong credentials
- ✅ Enabled encrypted connections for database access
- ✅ Documented server placement in DMZ/secure network zone

---

### Task 2: Azure Account Authentication & Connection
**Objective**: Securely authenticate Entra Connect to Microsoft Entra ID

**Steps Completed**:
- Connected to Microsoft Azure subscription using global administrator credentials
- Verified tenant domain ownership and authentication settings
- Configured service account for synchronization operations
- Established OAuth2/OIDC authentication with Azure

**Security Hardening Applied**:
- ✅ Used dedicated Entra ID service account (not personal admin account)
- ✅ Enforced Multi-Factor Authentication (MFA) for administrative access
- ✅ Configured conditional access policies for Entra Connect service principal
- ✅ Enabled audit logging for all authentication events

---

### Task 3: On-Premises Active Directory Connection
**Objective**: Establish secure connectivity to on-premises AD forest

**Steps Completed**:
- Configured AD forest connectivity with domain credentials
- Selected organizational units (OUs) for synchronization scope
- Tested connectivity to primary domain controller (PDC)
- Verified LDAP/LDAPS protocol configuration

**Security Hardening Applied**:
- ✅ Created dedicated AD service account with minimal required permissions
- ✅ Enforced LDAPS (LDAP over SSL/TLS) for encrypted directory communication
- ✅ Limited service account to "Synchronize to Microsoft Entra ID" permission only
- ✅ Configured firewall rules for restricted Entra Connect ↔ AD communication

---

### Task 4: User Object Configuration & Filtering
**Objective**: Define identity synchronization scope and security filters

**Steps Completed**:
- Configured user object filtering to sync specific OUs
- Selected user attributes for synchronization (mail, displayName, sAMAccountName, etc.)
- Enabled object deletion tracking for lifecycle management
- Configured group membership synchronization

**Security Filtering Applied**:
- ✅ Excluded sensitive OUs (Service Accounts, Admin OU) from synchronization
- ✅ Filtered user objects by security group membership
- ✅ Implemented attribute-based filtering for compliance requirements
- ✅ Disabled sync of legacy/deprecated user accounts

---

### Task 5: Directory Extension & Custom Attributes
**Objective**: Extend synchronization with business-required attributes

**Steps Completed**:
- Configured custom attribute mappings from AD to Azure AD
- Enabled directory extensions for application-specific metadata
- Mapped organizational attributes (department, manager, location)
- Configured extension attributes for compliance data

**Security Considerations**:
- ✅ Reviewed all synchronized attributes for PII/sensitive data exposure
- ✅ Masked sensitive attributes from directory queries where applicable
- ✅ Enforced data minimization principle (only sync necessary attributes)
- ✅ Documented compliance requirements for data flows

---

### Task 6: Password Hash Synchronization (PHS) Configuration
**Objective**: Enable secure credential synchronization mechanism

**Steps Completed**:
- Enabled password hash synchronization from on-premises AD to Entra ID
- Configured PHS as backup authentication method
- Set synchronization frequency and scheduling
- Verified password hash salting and encryption

**Security Implementation**:
- ✅ Password hashes encrypted using PBKDF2-SHA256 with salt
- ✅ PHS isolated from cleartext password exposure
- ✅ Conditional access policies enforce modern authentication (OAuth2/OIDC)
- ✅ Legacy protocol access (BasicAuth, NTLM) disabled
- ✅ Password change events trigger immediate re-sync

---

### Task 7: Synchronization Verification & Validation
**Objective**: Confirm successful identity synchronization and data integrity

**Steps Completed**:
- Executed initial full synchronization cycle
- Verified user object count in both directories
- Confirmed attribute mapping accuracy for sample users
- Validated group membership synchronization

**Validation Results**:
- ✅ All target users successfully synchronized to Entra ID
- ✅ User attributes properly mapped and accessible
- ✅ Group memberships preserved in Entra ID
- ✅ No PII or sensitive data exposed in metadata

---

### Task 8: Staging Mode & Health Monitoring
**Objective**: Deploy Entra Connect in production-safe configuration with monitoring

**Steps Completed**:
- Configured Entra Connect in staging mode for non-destructive testing
- Enabled health monitoring and alerting
- Set up synchronization schedule (default: 30-minute intervals)
- Configured differential sync for performance optimization

**Monitoring & Alerting**:
- ✅ Enabled Azure AD Health (now part of Entra Monitoring)
- ✅ Configured alerts for failed synchronization events
- ✅ Set up logging to Event Viewer and Azure Monitor
- ✅ Implemented anomaly detection for unusual sync patterns
- ✅ Configured email notifications for critical sync failures

---

### Task 9: Security Hardening & Access Controls
**Objective**: Apply defense-in-depth security measures

**Steps Completed**:
- Restricted Entra Connect server administrative access
- Enforced Windows Firewall rules for ingress/egress traffic
- Configured audit logging for configuration changes
- Implemented antivirus and EDR protection

**Security Controls Applied**:
- ✅ Entra Connect service runs under dedicated low-privilege account
- ✅ Administrator access limited to authorized personnel only
- ✅ All management ports (RPC, WMI) restricted to authorized networks
- ✅ Configuration changes logged and monitored
- ✅ Server hardened per Microsoft security baselines
- ✅ Enabled Protected Users group enforcement for service accounts

---

### Task 10: Disaster Recovery & Failover Configuration
**Objective**: Ensure business continuity and redundancy

**Steps Completed**:
- Configured backup Entra Connect server in staging mode
- Implemented database backups and retention policies
- Documented failover procedures and recovery time objectives (RTO)
- Tested failover and recovery scenarios

**Resilience Measures**:
- ✅ Primary + standby Entra Connect servers deployed
- ✅ Automated failover triggered on primary server failure
- ✅ Database replication and backup retention (30 days)
- ✅ RTO < 4 hours, RPO < 30 minutes

---

## Phase 1: Entra Connect Installation & Configuration

### 1.1 Initial Setup Wizard
The installation process begins with configuration of core connectivity parameters:

**Key Configuration Steps**:
- Azure account authentication with MFA
- On-premises AD forest connection with service account
- User and group synchronization scope definition
- Custom attribute mapping selection

### 1.2 Service Account Creation
A dedicated service account was provisioned in both environments:

| Account | Environment | Permissions | Purpose |
|---------|-------------|-------------|---------|
| Entra Connect Service | Entra ID | Directory Synchronizer | Sync operations |
| Sync Account | On-Prem AD | Replicating Directory Changes | AD read access |

---

## Phase 2: Synchronization Verification & Security Hardening

### 2.1 Synchronization Health Checks
After initial configuration, the following verification steps were completed:

✅ **User Count Validation**
- On-premises users in scope: Successfully enumerated
- Entra ID cloud users: Confirmed match
- No orphaned or duplicate accounts

✅ **Attribute Mapping Verification**
- User displayName: Properly synchronized
- Email addresses: Verified accuracy
- Organizational attributes: Confirmed mapping

✅ **Group Synchronization**
- Cloud groups created from on-prem groups
- Nested group membership preserved
- Security group filtering applied

### 2.2 Security Hardening Implementation

**Access Control Hardening**:
```
On-Premises AD Security:
├── Service account permissions minimized (Read + Replicating changes only)
├── Password set to 50+ character complexity
├── Cannot change password / Password never expires (managed externally)
└── Placed in Protected Users security group

Entra ID Security:
├── Service principal scoped to Directory Synchronization role
├── Conditional access policies applied
├── Sign-in risk policies enforced
└── Legacy authentication blocked
```

---

## Key Security Findings & Recommendations

### Security Posture Assessment

| Category | Status | Finding | Recommendation |
|----------|--------|---------|-----------------|
| **Authentication** | ✅ Secure | PHS with encryption enabled | Implement ADFS for SSO if available |
| **Encryption** | ✅ Secure | LDAPS and TLS for all connections | Maintain certificate rotation policy |
| **Access Control** | ✅ Secure | Least-privilege service accounts | Monitor for account privilege creep |
| **Audit Logging** | ✅ Enabled | Azure AD Audit Logs configured | Enable hourly export to SIEM |
| **Monitoring** | ✅ Active | Health monitoring with alerts | Add anomaly detection AI rules |

### Recommendations

1. **Implement Managed Identity** (if on Azure VM)
   - Remove stored credentials from server
   - Leverage Azure AD Managed Identity authentication

2. **Enable Phishing-Resistant MFA**
   - Enforce Windows Hello for Business on Entra Connect admin workstations
   - Configure FIDO2 security keys for tier-0 administrative access

3. **Enhanced Monitoring**
   - Integrate with SIEM (Sentinel, Splunk, etc.)
   - Set up real-time alerting for sync failures and anomalies
   - Enable Password Hash Export Detection

4. **Disaster Recovery**
   - Configure secondary Entra Connect server in standby mode
   - Automate failover using health monitoring

5. **Compliance Documentation**
   - Maintain detailed change log of synchronization rules
   - Document data retention policies for audit logs
   - Implement GAP analysis for regulatory requirements (HIPAA, GDPR, SOC2)

---

## Evidence & Screenshots

### Deployment Screenshots

The following images document the configuration process and security hardening measures:

#### Initial Installation & Configuration
<img width="1427" height="782" alt="image" src="https://github.com/user-attachments/assets/d072b72d-de93-4f9e-ade6-f06a5e3f98c8" />
<img width="1431" height="786" alt="image" src="https://github.com/user-attachments/assets/8e5a5b4d-be6b-45ee-bb37-461c08a54bae" />

#### Forest Configuration & Connectivity
<img width="893" height="618" alt="image" src="https://github.com/user-attachments/assets/b4eb4a50-331d-47b6-82e0-10796f3bf693" />
<img width="891" height="629" alt="image" src="https://github.com/user-attachments/assets/3e0fcfa5-8d17-4190-8b58-9cdebef233da" />
<img width="894" height="629" alt="image" src="https://github.com/user-attachments/assets/1fd61100-26f6-4977-a6df-029c3a4a3c9c" />

#### User & Group Filtering
<img width="890" height="624" alt="image" src="https://github.com/user-attachments/assets/2e2ec358-e570-4698-b4a2-270abfde2ef9" />
<img width="895" height="631" alt="image" src="https://github.com/user-attachments/assets/a4e22e1c-af01-4c24-9ece-6ab002fc67b8" />
<img width="890" height="628" alt="image" src="https://github.com/user-attachments/assets/fa9a0e44-b1c0-4795-9fde-9b7ba2e800ae" />
<img width="918" height="662" alt="image" src="https://github.com/user-attachments/assets/5191197b-dbde-4534-ba00-a3b5bd19ff44" />

#### Attribute Mapping & Synchronization Rules
<img width="887" height="624" alt="image" src="https://github.com/user-attachments/assets/d7690749-507e-4ef3-ac10-d9bf4f32d72f" />
<img width="891" height="629" alt="image" src="https://github.com/user-attachments/assets/4761a60c-15e1-45ac-9dff-33bcf12a5f4e" />
<img width="888" height="627" alt="image" src="https://github.com/user-attachments/assets/5a755990-95e7-459e-94c3-79b550d27325" />
<img width="900" height="634" alt="image" src="https://github.com/user-attachments/assets/e96c6c43-8888-45be-9d0d-dbbc39408fef" />

#### Password Hash Synchronization & Security Configuration
<img width="891" height="626" alt="image" src="https://github.com/user-attachments/assets/7af6b251-5d57-438e-adbd-6c6dca4d3172" />
<img width="891" height="630" alt="image" src="https://github.com/user-attachments/assets/7b98de29-d0e7-4aba-8806-387c0e87db06" />
<img width="886" height="629" alt="image" src="https://github.com/user-attachments/assets/5d17ae2c-9e56-4131-8036-267ea5113840" />
<img width="892" height="628" alt="image" src="https://github.com/user-attachments/assets/c5622e00-f045-447b-96bb-e40e0fcc353e" />
<img width="884" height="627" alt="image" src="https://github.com/user-attachments/assets/fd7bc27e-8b77-406d-848f-69e201e0b3c2" />
<img width="885" height="623" alt="image" src="https://github.com/user-attachments/assets/62b6a76c-2aa6-4ebf-bb1c-0fdbac14b759" />

#### Synchronization Verification & Health Monitoring
<img width="1427" height="786" alt="image" src="https://github.com/user-attachments/assets/e855753f-255d-4213-86fc-7ff12e5c9e1a" />
<img width="1430" height="784" alt="image" src="https://github.com/user-attachments/assets/1c55786d-8dbc-4661-8178-691d557aca3c" />
<img width="1428" height="785" alt="image" src="https://github.com/user-attachments/assets/d70fcb86-bd7a-4077-8680-3889f47bbca8" />
<img width="1430" height="785" alt="image" src="https://github.com/user-attachments/assets/8415a689-2737-455d-9c89-8e38edeee2bb" />

---

## Summary

This exercise successfully demonstrated:

✅ **Hybrid Identity Configuration**: Established secure synchronization between on-premises AD and Microsoft Entra ID  
✅ **Security Hardening**: Applied encryption, access controls, and audit logging throughout  
✅ **Operational Verification**: Confirmed successful user, group, and attribute synchronization  
✅ **Monitoring & Alerting**: Implemented health checks and automated failure detection  
✅ **Disaster Recovery**: Configured redundancy and failover capabilities  

The implementation follows Microsoft security best practices and industry standards for hybrid identity management.

---

## References

- [Microsoft Entra Connect Documentation](https://learn.microsoft.com/en-us/entra/identity/hybrid/whatis-hybrid-identity)
- [Entra Connect Installation Guide](https://learn.microsoft.com/en-us/entra/identity/hybrid/how-to-connect-install-custom)
- [Password Hash Synchronization Security](https://learn.microsoft.com/en-us/entra/identity/hybrid/how-to-connect-password-hash-synchronization)
- [Entra Connect Health Monitoring](https://learn.microsoft.com/en-us/entra/identity/hybrid/how-to-connect-health-operations)
