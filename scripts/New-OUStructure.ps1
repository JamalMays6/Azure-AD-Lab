<#
.SYNOPSIS
    Creates the department-based OU structure for the r3dlab01.local domain.

.DESCRIPTION
    Replace the body of this script with your actual OU-creation script from the lab.
    Departments used in the lab: Finance, HR, IT, Sales.

.NOTES
    Placeholder — paste your real script here, then delete this notice block.
#>

$Departments = @("Finance", "HR", "IT", "Sales")
$DomainDN    = (Get-ADDomain).DistinguishedName

foreach ($Dept in $Departments) {
    New-ADOrganizationalUnit -Name $Dept -Path $DomainDN -ProtectedFromAccidentalDeletion $true
    Write-Output "Created OU: $Dept"
}
