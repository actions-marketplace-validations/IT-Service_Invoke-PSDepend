#!/usr/bin/env pwsh

$Param = Get-ActionInput 'param-id';

$installModParams = @{ Name = 'Pester'; Force = $true };

if ($Version)
{
	$installModParams.Add('RequiredVersion', $Version)
};

Write-ActionInfo 'checking for Pester module...'

$modules = Get-Module -ListAvailable Pester;
$requiredPester = $null
if ( $Version )
{
	$requiredPester = $modules | Where-Object { $_.Version -eq $Version };
}
else
{
	$requiredPester = $modules | Sort-Object Version | Select-Object -Last 1;
};

if ( $requiredPester )
{
	Write-ActionInfo ('Pester module version {0} already installed.' -f $requiredPester.Version);
}
else
{
	Write-ActionInfo 'installing Pester module {0}...' -f "version: ${version}";
	$ProgressPreference = 'SilentlyContinue';
	Install-Module @installModParams;
}

$importedModule = Import-Module @installModParams -PassThru;

Write-ActionInfo ("running Pester version {0} on '$script'" -f $importedModule.Version);

Set-ActionOutput -Name 'random-number' -Value 'output-value';

Write-ActionInfo ("Output info");
