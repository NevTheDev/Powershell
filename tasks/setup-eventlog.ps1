. ./setup-variables.ps1

If($logName){
    $logFileExists = Get-EventLog -list | Where-Object {$_.logdisplayname -eq $logName} 
    if (! $logFileExists) {
        New-EventLog -LogName $logName -Source $logSource
    }
}