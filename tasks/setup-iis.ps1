
Import-Module WebAdministration

#Change the below Variables 
$siteName = ""
$siteDirectory = ""
$siteUrl = ""
$appPoolUsername = ""
$appPoolPassword = ""
$mediaFolderPath = ""


#Code below will setup iis for the detail above
$currentDir = (Get-Item -Path ".\" -Verbose).FullName
$rootDirectory = (Get-Item $currentDir).Parent.FullName 
$projectDirectory = Join-Path $rootDirectory $siteDirectory
$apppool = "IIS:\apppools\$siteName"
$iissite = "IIS:\sites\$siteName"

#Create the App Pool for the site
If (-Not (Test-Path $apppool)) {
	New-Item $apppool
	$appPool = Get-Item $apppool 
    $appPool.processModel.userName = $appPoolUsername
    $appPool.processModel.password = $appPoolPassword
    $appPool.processModel.identityType = 3
    $appPool | Set-Item
}

#Check if the site exists in IIS
If (-Not (Test-Path $iissite)) {
	New-Item $iissite -Bindings @{protocol="http";bindingInformation="*:80:"} -PhysicalPath $projectDirectory
	Set-ItemProperty $iissite -name applicationPool -value $siteName
}Else{
    #Change the path to point to the project directory
    Set-ItemProperty $iissite -name physicalPath -value $projectDirectory
}

##Clear the binding 
Clear-ItemProperty $iissite -Name bindings

#Add the new bindings
New-WebBinding -Name $siteName -IPAddress "*" -Port 80 -HostHeader $siteUrl

$iisMediaFolder = "$iissite\media"

If (-Not (Test-Path $iisMediaFolder)) {
    New-Item $iisMediaFolder -type VirtualDirectory -PhysicalPath $mediaFolderPath
}else{
    Set-ItemProperty $iisMediaFolder -name physicalPath -value $mediaFolderPath
}