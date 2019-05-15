Import-Module .\DataTable.psm1 -Force

$curObj = New-Object -TypeName PSObject
Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value (get-date)
Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value "TaskNameValue"
Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value "MachineNameValue"

$dt = $curObj   | Out-DataTable

$dt