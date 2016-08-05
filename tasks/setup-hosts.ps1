$hostsPath = "$env:windir\System32\drivers\etc\hosts"
$hosts = get-content $hostsPath





$matchedhosts = $hosts | Foreach {
    if ($_ -match '^\s*(.*?\d{1,3}.*?leadmanager.*)'){
        $matches[1]
    } else {
        $_
    }
}

Write-Host $matchedhosts