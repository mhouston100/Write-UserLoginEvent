$allEvents = Get-WinEvent -LogName ForwardedEvents | ?{$_.ID -ne 111}

$outEvents = @()

foreach ($curEvent in $allEvents){
    switch ($curEvent.ID) {
        4647 { $curEvent }
        4624 { $curEvent }
    }
}