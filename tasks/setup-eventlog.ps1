$logName = "";
$logSource = ""

$logFileExists = Get-EventLog -list | Where-Object {$_.logdisplayname -eq $logName} 
if (! $logFileExists) {
    New-EventLog -LogName $logName -Source $logSource
}