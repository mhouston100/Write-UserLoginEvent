Import-Module .\DataTable.psm1

$allEvents = Get-WinEvent -LogName ForwardedEvents | ?{$_.Id -ne 111}

$outEvents = New-Object -TypeName System.Collections.ArrayList

foreach ($curEvent in $allEvents){
    $curObj = $null
    switch ($curEvent.ID) {
        4624    { $curObj = New-Object -TypeName PSObject
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value ([datetime]$curEvent.TimeCreated)
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value $curEvent.TaskDisplayName
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value $curEvent.MachineName 
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name UserName -Value ((($curEvent.Message).Split([Environment]::NewLine)[36]).split(":")[1]).Trim()
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name LoginID -Value ((($curEvent.Message).Split([Environment]::NewLine)[40]).split(":")[1]).Trim()
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name SourceIP -Value ((($curEvent.Message).Split([Environment]::NewLine)[64]).split(":")[1]).Trim()
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name ID -Value $curEvent.Id
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name RecordID -Value $curEvent.EventRecordID
                }
        4647    { $curObj = New-Object -TypeName PSObject
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value ([datetime]$curEvent.TimeCreated)
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value $curEvent.TaskDisplayName
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value $curEvent.MachineName 
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name UserName -Value ((($curEvent.Message).Split([Environment]::NewLine)[8]).split(":")[1]).Trim()
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name LoginID -Value ((($curEvent.Message).Split([Environment]::NewLine)[12]).split(":")[1]).Trim()
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name SourceIP -Value ""
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name ID -Value $curEvent.Id
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name RecordID -Value $curEvent.EventRecordID
                }
        4778    { $curObj = New-Object -TypeName PSObject
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value ([datetime]$curEvent.TimeCreated)
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value "Reconnect"
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value $curEvent.MachineName 
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name UserName -Value ((($curEvent.Message).Split([Environment]::NewLine)[6]).split(":")[1]).Trim()
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name LoginID -Value ((($curEvent.Message).Split([Environment]::NewLine)[10]).split(":")[1]).Trim()
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name SourceIP -Value ((($curEvent.Message).Split([Environment]::NewLine)[24]).split(":")[1]).Trim()
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name ID -Value $curEvent.Id
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name RecordID -Value $curEvent.EventRecordID
                }
        4800    { $curObj = New-Object -TypeName PSObject
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value ([datetime]$curEvent.TimeCreated)
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value "Locked"
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value $curEvent.MachineName 
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name UserName -Value ((($curEvent.Message).Split([Environment]::NewLine)[8]).split(":")[1]).Trim()
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name LoginID -Value ((($curEvent.Message).Split([Environment]::NewLine)[12]).split(":")[1]).Trim()
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name SourceIP -Value ""
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name ID -Value $curEvent.Id
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name RecordID -Value $curEvent.EventRecordID
                }

        Default { }
    }
    $outEvents += $curObj
}

$dataTable = Out-DataTable $outEvents

