## Write-UserLoginEvent

# Description

This script will take Windows Event Log login / logout events and write them to an SQL database.

Events that are tracked:

* 4624 - Logon
* 4647 - Log Off
* 4778 - Reconnect
* 4800 - Lock
* 4801 - Unlock

The script will pull relevent details from the 'description' field in the event and part this out to a datatable.

Once in the SQL database you can use SSRS (SQL Server Reporting Services) to create some reports, or any other reporting system.