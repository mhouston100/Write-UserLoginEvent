function Get-Type 
{ 
    param($type) 
 
$types = @( 
'System.Boolean', 
'System.Byte[]', 
'System.Byte', 
'System.Char', 
'System.Datetime', 
'System.Decimal', 
'System.Double', 
'System.Guid', 
'System.Int16', 
'System.Int32', 
'System.Int64', 
'System.Single', 
'System.UInt16', 
'System.UInt32', 
'System.UInt64') 
 
    if ( $types -contains $type ) { 
        Write-Output "$type" 
    } 
    else { 
        Write-Output 'System.String' 
         
    } 
} #Get-Type 
 
function Out-DataTable
{ 
    [CmdletBinding()] 
    param([Parameter(Position=0, Mandatory=$true, ValueFromPipeline = $true)] [PSObject[]]$InputObject) 
 
    Begin 
    { 
        $dt = new-object Data.datatable   
        $First = $true  
    } 
    Process 
    { 
        Write-Output "test"
        foreach ($object in $InputObject) 
        { 
            $DR = $DT.NewRow()
            foreach($property in $object.PsObject.get_properties()) 
            {   
                if ($first) 
                {   
                    $Col =  new-object Data.DataColumn   
                    $Col.ColumnName = $property.Name.ToString()   
                    if ($property.value) 
                    { 
                        if ($property.value -isnot [System.DBNull]) { 
                            $Col.DataType = [System.Type]::GetType("$(Get-Type $property.TypeNameOfValue)") 
                         } 
                    } 
                    $DT.Columns.Add($Col) 
                }   
                if ($property.Gettype().IsArray) { 
                    $DR.Item($property.Name) =$property.value | ConvertTo-XML -AS String -NoTypeInformation -Depth 1 
                }   
               else { 
                    $DR.Item($property.Name) = $property.value 
                } 
            }   
            $DT.Rows.Add($DR)   
            $First = $false 
        } 
    }  
      
    End 
    { 
        Write-Output @(,($dt)) 
    } 
 
} #Out-DataTable

$allEvents = Get-WinEvent -LogName ForwardedEvents | Where-Object{$_.Id -ne 111} | Sort-Object TimeCreated

$outEvents = @()
$outDataTable = $null

foreach ($curEvent in $allEvents){
    $curObj = $null
    switch ($curEvent.ID) {
        4624    { 
                $curObj = New-Object -TypeName PSObject
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value ([datetime]$curEvent.TimeCreated)
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value $curEvent.TaskDisplayName
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value $curEvent.MachineName 
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name UserName -Value ((($curEvent.Message).Split([Environment]::NewLine)[36]).split(":")[1]).Trim()
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name LoginID -Value ((($curEvent.Message).Split([Environment]::NewLine)[40]).split(":")[1]).Trim()
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name SourceIP -Value ((($curEvent.Message).Split([Environment]::NewLine)[64]).split(":")[1]).Trim()
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name ID -Value $curEvent.Id
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name RecordID -Value $curEvent.RecordID
                }
        4647    { 
                $curObj = New-Object -TypeName PSObject
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value ([datetime]$curEvent.TimeCreated)
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value $curEvent.TaskDisplayName
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value $curEvent.MachineName 
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name UserName -Value ((($curEvent.Message).Split([Environment]::NewLine)[8]).split(":")[1]).Trim()
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name LoginID -Value ((($curEvent.Message).Split([Environment]::NewLine)[12]).split(":")[1]).Trim()
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name SourceIP -Value "Not Available"
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name ID -Value $curEvent.Id
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name RecordID -Value $curEvent.RecordID
                }
        4778    { 
                $curObj = New-Object -TypeName PSObject
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value ([datetime]$curEvent.TimeCreated)
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value "Reconnect"
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value $curEvent.MachineName 
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name UserName -Value ((($curEvent.Message).Split([Environment]::NewLine)[6]).split(":")[1]).Trim()
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name LoginID -Value ((($curEvent.Message).Split([Environment]::NewLine)[10]).split(":")[1]).Trim()
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name SourceIP -Value ((($curEvent.Message).Split([Environment]::NewLine)[24]).split(":")[1]).Trim()
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name ID -Value $curEvent.Id
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name RecordID -Value $curEvent.RecordID
                }
        4800    { 
                $curObj = New-Object -TypeName PSObject
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value ([datetime]$curEvent.TimeCreated)
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value "Locked"
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value $curEvent.MachineName 
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name UserName -Value ((($curEvent.Message).Split([Environment]::NewLine)[8]).split(":")[1]).Trim()
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name LoginID -Value ((($curEvent.Message).Split([Environment]::NewLine)[12]).split(":")[1]).Trim()
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name SourceIP -Value "Not Available"
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name ID -Value $curEvent.Id
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name RecordID -Value $curEvent.RecordID
                }
        4801    { 
                $curObj = New-Object -TypeName PSObject
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name TimeCreated -Value ([datetime]$curEvent.TimeCreated)
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name Action -Value "Unlocked"
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name MachineName -Value $curEvent.MachineName 
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name UserName -Value ((($curEvent.Message).Split([Environment]::NewLine)[8]).split(":")[1]).Trim()
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name LoginID -Value ((($curEvent.Message).Split([Environment]::NewLine)[12]).split(":")[1]).Trim()
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name SourceIP -Value "Not Available"
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name ID -Value $curEvent.Id
                Add-Member -InputObject $curObj -MemberType NoteProperty -Name RecordID -Value $curEvent.RecordID
                }

        Default { }
    }
    #Write-Output "Writing $($curObj.RecordID) to DataTable"
    #Out-DataTable -InputObject $curObj
    #Write-Output "DataTable Completed."
    $outEvents += $curObj
    
}

$outDataTable = Out-DataTable -InputObject $outEvents

$outDataTable