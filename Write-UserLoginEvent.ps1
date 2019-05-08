$allEvents = Get-WinEvent -LogName ForwardedEvents | ?{$_.Id -ne 111}

$outEvents = @()

foreach ($curEvent in $allEvents){
    $curObj = $null
    switch ($curEvent.ID) {
        4647    { $curObj = New-Object -TypeName PSObject
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value ([datetime]$curEvent.TimeCreated)
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value $curEvent.TaskDisplayName
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value $curEvent.MachineName 
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name UserName -Value ((($curEvent.Message).Split([Environment]::NewLine)[8]).split(":")[1]).Trim()
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name LoginID -Value ((($curEvent.Message).Split([Environment]::NewLine)[12]).split(":")[1]).Trim()
                    #Add-Member -InputObject $curObj -MemberType NoteProperty -Name RawMessage -Value $curEvent.Message
                }
        4624    { $curObj = New-Object -TypeName PSObject
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value ([datetime]$curEvent.TimeCreated)
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value $curEvent.TaskDisplayName
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value $curEvent.MachineName 
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name UserName -Value ((($curEvent.Message).Split([Environment]::NewLine)[36]).split(":")[1]).Trim()
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name LoginID -Value ((($curEvent.Message).Split([Environment]::NewLine)[40]).split(":")[1]).Trim()
                    #Add-Member -InputObject $curObj -MemberType NoteProperty -Name RawMessage -Value $curEvent.Message
                }
        Default { }
    }
    $outEvents += $curObj
}

$outEvents | Sort-Object TimeCreated