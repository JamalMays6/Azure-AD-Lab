# Lab notes

Reference details for the environment built in this lab. See the [Loom walkthrough](https://loom.com/share/a5a64df4242d4ab890a3e684d92d975a) for the full build.

## Domain

- Forest/domain: `r3dlab01.local` (new forest)
- Domain controller: `R3d-testVM` (Standard D2s v7)

## Organizational units

- Finance
- HR
- IT
- Sales
- Computers (default)
- Test

Each department OU holds a matching security group and its users: `R3dlab01-IT_Admins`, `R3dlab01-Finance_Users`, `R3dlab01-HR_Users`, `R3dlab01-Sales_Users`.

## Bulk user provisioning

Users are created via `scripts/Add-BulkUsers.ps1`, which reads `data/NewUsers.csv` and places each user in the correct department OU and security group. The CSV drives 20 users across IT, Finance, HR, and Sales — 5 each.

![PowerShell ISE running Add-BulkUsers.ps1](screenshots/powershell-bulk-users-output.jfif)

## GPO: R3dlab01-IT-GPO1 (linked to the IT OU)

**Password policy** — Computer Configuration → Policies → Windows Settings → Security Settings → Account Policies → Password Policy:
- Minimum password length: 12 characters
- Password must meet complexity requirements: Enabled

![GPO password policy settings](screenshots/gpo-password-policy.jfif)

**Inactivity lock** — machine locks after 15 minutes (900 seconds) of inactivity.

**Removable storage** — Computer Configuration → Policies → Administrative Templates → System → Removable Storage Access:
- All Removable Storage classes: Deny all access — Enabled

![GPO removable storage access settings](screenshots/gpo-removable-storage.jfif)

### OU-linked GPOs don't set domain password policy

Windows enforces one password and account lockout policy per domain for domain (Kerberos) accounts, sourced from the Default Domain Policy, not from whatever GPO is linked to a user's OU. A password policy linked to an OU only affects local accounts on computer objects inside that OU.

To apply different password requirements to different groups of users within the same domain, use **Fine-Grained Password Policies (PSOs)** instead of an OU-linked GPO.

## Common admin tasks (scripts/Manage-AccountTasks.ps1)

- Reset a user's password and require change at next logon
- Disable a departed employee's account (e.g. `david.darks`)
- Unlock a locked-out account (e.g. `carol.charles`)
- Audit disabled accounts: `Search-ADAccount -AccountDisabled | Select-Object Name, SamAccountName`
