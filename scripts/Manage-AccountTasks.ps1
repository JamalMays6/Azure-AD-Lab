<#
.SYNOPSIS
    Common day-to-day Active Directory admin tasks: disable, unlock, and audit accounts.

.DESCRIPTION
    Reference commands used in the lab for password resets, disabling departed
    employees, and unlocking accounts. Adjust identities as needed.
#>

# Disable a departed employee's account
Disable-ADAccount -Identity "david.darks"

# Confirm which accounts are currently disabled
Search-ADAccount -AccountDisabled | Select-Object Name, SamAccountName

# Unlock a locked-out account
Unlock-ADAccount -Identity "carol.charles"

# Reset a user's password and require a change at next logon
# Set-ADAccountPassword -Identity "<samaccountname>" -Reset -NewPassword (Read-Host -AsSecureString "New password")
# Set-ADUser -Identity "<samaccountname>" -ChangePasswordAtLogon $true
