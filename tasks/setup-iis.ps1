. ./setup-variables.ps1
Import-Module WebAdministration

$apppool = "IIS:\apppools\$siteName"
$iissite = "IIS:\sites\$siteName"

## Create the App Pool for the site
If (-Not (Test-Path $apppool)) {
	New-Item $apppool	
}
$appPool = Get-Item $apppool 
$appPool.processModel.userName = $appPoolUsername
$appPool.processModel.password = $appPoolPassword
$appPool.processModel.identityType = 3
$appPool | Set-Item


## Check if the site exists in IIS
If (-Not (Test-Path $iissite)) {
	New-Item $iissite -Bindings @{protocol="http";bindingInformation="*:80:"} -PhysicalPath $projectDirectory
	Set-ItemProperty $iissite -name applicationPool -value $siteName
}Else{
    #Change the path to point to the project directory
    Set-ItemProperty $iissite -name physicalPath -value $projectDirectory
}

## Clear the binding 
Clear-ItemProperty $iissite -Name bindings

## Loop over the sitehosts and add iis bindings to the site
Foreach($site in $siteHosts){
    ## Add the new bindings
    New-WebBinding -Name $siteName -IPAddress "*" -Port 80 -HostHeader $site
}

If($mediaFolderPath){
    $iisMediaFolder = "$iissite\media"
    If (-Not (Test-Path $iisMediaFolder)) {
        New-Item $iisMediaFolder -type VirtualDirectory -PhysicalPath $mediaFolderPath
    }else{
        Set-ItemProperty $iisMediaFolder -name physicalPath -value $mediaFolderPath
    }
}

## Set any virtual directory to run under the app pool user
$virtualDirs = Get-WebVirtualDirectory -site $siteName
ForEach($vdir in $virtualDirs){
    $xpath = ($vdir | Select -Property "ItemXPath").ItemXPath
    $fullPath = $xpath.Substring(1)
    Set-WebConfigurationProperty $fullPath -Name "username" -Value $appPoolUsername
    Set-WebConfigurationProperty $fullPath -Name "password" -Value $appPoolPassword
}