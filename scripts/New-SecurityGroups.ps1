<#
.SYNOPSIS
    Creates department security groups matching the OU structure.

.DESCRIPTION
    Replace the body of this script with your actual security-group creation script from the lab.
    Groups follow the pattern R3dlab01-<Department>, one per OU.

.NOTES
    Placeholder — paste your real script here, then delete this notice block.
#>

$Departments = @("Finance", "HR", "IT", "Sales")

foreach ($Dept in $Departments) {
    $OUPath = (Get-ADOrganizationalUnit -Filter "Name -eq '$Dept'").DistinguishedName
    New-ADGroup -Name "R3dlab01-$Dept" -GroupScope Global -GroupCategory Security -Path $OUPath
    Write-Output "Created group: R3dlab01-$Dept"
}
