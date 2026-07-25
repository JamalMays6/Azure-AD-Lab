# 1 — Point this at the CSV's location on the VM (default: C:\Temp\NewUsers.csv)
$csvPath = "C:\Temp\NewUsers.csv"

# 2 — Set a shared temporary password; users are forced to change it at first logon
$password = ConvertTo-SecureString "Welcome@2026!" -AsPlainText -Force

# 3 — Loop through the CSV and create each user
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    try {
        New-ADUser -Name "$($user.FirstName) $($user.LastName)" `
            -GivenName $user.FirstName `
            -Surname $user.LastName `
            -SamAccountName $user.SamAccountName `
            -UserPrincipalName "$($user.SamAccountName)@R3dlab01.local" `
            -Path $user.OUPath `
            -AccountPassword $password `
            -Enabled $true `
            -ChangePasswordAtLogon $true `
            -ErrorAction Stop

        Add-ADGroupMember -Identity $user.Group -Members $user.SamAccountName -ErrorAction Stop

        Write-Host "Created: $($user.SamAccountName) -> $($user.Group)" -ForegroundColor Green
    }
    catch {
        Write-Host "FAILED: $($user.SamAccountName) - $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nDone. $($users.Count) users processed."
