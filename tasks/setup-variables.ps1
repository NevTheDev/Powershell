
## Name of the site
$siteName = "Powershell Testing Site"
$netVersion = "4.0"
## Root Directory of the IIS site
$siteDirectory = "testing"
$solutionName = "testing.web.ui.sln"
##Application Pool Username and Password that the site will run under 
$appPoolUsername = "omc\portal"
$appPoolPassword = "P@55word"
#List of any host names that need to be added as site binding and into the hosts file
$siteHosts = @(
    "test.dev.cwom.co.uk"
)
#Path to the shared media folder for umbraco sites, this can be left blank if no media folder is required
$mediaFolderPath = ""
#Event Log Name and Source Name, can be left blank if no event log needed
$logName = "";
$logSource = ""
## Code below will setup iis for the detail above
$currentDir = (Get-Item -Path ".\" -Verbose).FullName
$rootDirectory = (Get-Item $currentDir).Parent.FullName 
$projectDirectory = Join-Path $rootDirectory $siteDirectory