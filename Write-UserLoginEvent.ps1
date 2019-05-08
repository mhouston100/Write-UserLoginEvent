$allEvents = Get-WinEvent -LogName ForwardedEvents | Select *

$outEvents = @()

foreach ($curEvent in $allEvents){
    switch ($curEvent.ID) {
        4647    { $curObj = New-Object -TypeName PSObject
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value $curEvent.TimeCreated
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value $curEvent.TaskDisplayName
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value $curEvent.MachineName 
                    Add-Member -InputObject $curObj -MemberType NoteProperty -Name UserName -Value ($curEvent.Message.Split([Environment]::NewLine)[8])
                }
    }
    $outEvents += $curEvent
}

$outEvents