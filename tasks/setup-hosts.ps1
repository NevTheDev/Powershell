. ./setup-variables.ps1

$hostsPath = "$env:windir\System32\drivers\etc\hosts"
$hosts = (get-content $hostsPath) -join "`n"
$sectionStartMarker = "#MARKER -- $siteName --"
$endStartMarker = "#ENDMARKER -- $siteName --"

if(-Not ($hosts -match $sectionStartMarker)){
    Write-Host "Marker Not Found - removing site old entries";
    Foreach($site in $siteHosts){
        $hosts = $hosts -replace "(.*?\d{1,3}\s*?)$site"
    }
}else{
    $hosts = $hosts -replace "$sectionStartMarker[.|\s|\w|\-]*$endStartMarker"
}

$sitesData = -join "`n", $sectionStartMarker
$sitesData = -join $sitesData, "`n"
Foreach($site in $siteHosts){
    $sitesData = -join $sitesData, "127.0.0.1`t$site`n"
}

$sitesData = -join $sitesData, $endStartMarker
$sitesData = -join $sitesData , "`n"
$hosts = "$hosts $sitesData"

Out-File $hostsPath -inputobject $hosts
 