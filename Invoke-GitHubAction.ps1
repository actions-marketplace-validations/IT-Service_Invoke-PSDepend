#!/usr/bin/env pwsh

Enter-ActionOutputGroup -Name 'Repositories preparing';
try
{
	Set-PSRepository -Name PSGallery -InstallationPolicy Trusted;
	Register-PackageSource -Name 'nuget.org' -Location 'https://api.nuget.org/v3/index.json' -ProviderName NuGet -Trusted -Force | Out-Null;
}
finally
{
	Exit-ActionOutputGroup;
};

Enter-ActionOutputGroup -Name 'PSDepend installation';
try
{
	$ModuleName = 'PSDepend';

	$installModuleParams = @{ Name = $ModuleName; Force = $true };
	$VersionParam = ( Get-ActionInput 'version' );
	if ( $VersionParam -ne 'latest' )
	{
		$Version = $VersionParam;
	};

	if ( $Version )
	{
		$installModParams.Add( 'RequiredVersion', $Version );
	};

	Write-ActionInfo ( 'checking for {0} module...' -f $ModuleName );

	$modules = Get-Module -ListAvailable -Name $ModuleName;
	$requiredModule = $null;
	if ( $Version )
	{
		$requiredModule = $modules | Where-Object { $_.Version -eq $Version };
	}
	else
	{
		$requiredModule = $modules | Sort-Object Version | Select-Object -Last 1;
	};

	if ( $requiredModule )
	{
		Write-ActionInfo ('{0} module version {1} already installed.' -f $requiredModule.Name, $requiredModule.Version);
	}
	else
	{
		Write-ActionInfo ( 'installing {0} module version {1}...' -f $ModuleName, $Version );
		$ProgressPreference = 'SilentlyContinue';
		Install-Module @installModuleParams;
	};

	Import-Module @installModuleParams;
}
finally
{
	Exit-ActionOutputGroup;
};

Invoke-PSDepend `
	-Recurse:( ( Get-ActionInput 'recurse' ) -eq 'true' ) `
	-Confirm:$false `
	-Verbose:( ( Get-ActionInput 'verbose' ) -eq 'true' );
