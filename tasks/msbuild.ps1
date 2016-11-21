. ./setup-variables.ps1

#Lookup the version of MSBuild to use
$msBuildRegKey = "HKLM:\SOFTWARE\Microsoft\MSBuild\ToolsVersions\$netVersion"
$regProperty = "MSBuildToolsPath"

$msbuild = join-path -path (Get-ItemProperty $msBuildRegKey).$regProperty -childpath "msbuild.exe"

$options = "/p:Configuration=release,VisualStudioVersion=14.0 /v:minimal"

$solutionPath = Join-Path $projectDirectory $solutionName

$clean = $msbuild + " $solutionPath " + $options + " /t:Clean"
$build = $msbuild + " $solutionPath " + $options + " /t:Build"

Write-Host $clean;
Write-Host $build;

Invoke-Expression $clean
Invoke-Expression $build