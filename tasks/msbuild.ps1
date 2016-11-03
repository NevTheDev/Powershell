. ./setup-variables.ps1

#$msbuild = "C:\Program Files (x86)\MSBuild\14.0\Bin\msbuild.exe"


$msbuild = $env:systemroot + "\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"



$options = "/p:Configuration=release,VisualStudioVersion=14.0 /v:minimal"

$solutionPath = Join-Path $projectDirectory $solutionName


$clean = $msbuild + " $solutionPath " + $options + " /t:Clean"
$build = $msbuild + " $solutionPath " + $options + " /t:Build"

Write-Host $clean;
Write-Host $build;

Invoke-Expression $clean
Invoke-Expression $build