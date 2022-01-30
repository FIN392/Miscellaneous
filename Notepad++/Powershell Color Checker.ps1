#Region x
	This is the default text
#Endregion x

<#
	Multiline comment
#>

# One line comment

# Strings
'qwe'
"https://github.com/FIN392"

{
	# Your code goes here
	 
	 
}

# Symbols
\ | @  ~ & / ( ) = [ ] { }  . - : _ < >

# Variable (general)
$Variable

# Variables (pre-defined)
$? $^ $$ $args $ConfirmPreference $DebugPreference $EnabledExperimentalFeatures $Error $ErrorActionPreference $ErrorView
$ExecutionContext $false $FormatEnumerationLimit $HOME $Host $InformationPreference $input $IsCoreCLR $IsLinux $IsMacOS
$IsWindows $MaximumHistoryCount $MyInvocation $NestedPromptLevel $null $OutputEncoding $PID $PROFILE $ProgressPreference
$PSBoundParameters $PSCommandPath $PSCulture $PSDefaultParameterValues $PSEdition $PSEmailServer $PSHOME $PSScriptRoot
$PSSessionApplicationName $PSSessionConfigurationName $PSSessionOption $PSStyle $PSUICulture $PSVersionTable $PWD
$ShellId $StackTrace $true $VerbosePreference $WarningPreference $WhatIfPreference 

# Keywords
begin break catch class continue data define do dynamicparam else elseif end exit filter finally for from function if
in inlinescript parallel param process return switch throw trap try until using var while workflow 

# Alias
? % ac cat cd chdir clc clear clhy cli clp cls clv cnsn compare copy cp cpi cpp cvpa dbp del diff dir dnsn ebp echo
epal epcsv erase etsn exsn fc fhx fimo fl foreach ft fw gal gbp gc gcai gcb gci gcim gcls gcm gcms gcs gdr gerr ghy gi
gin gjb gl gm gmo gp gps gpv group gsn gsv gtz gu gv h history icim icm iex ihy ii inmo ipal ipcsv ipmo irm iwr kill ls
man md measure mi mount move mp mv nal ncim ncms ncso ndr ni nmo nsn nv ogv oh popd ps pumo pushd pwd r rbp rcie rcim
rcjb rcms rcsn rd rdr ren ri rjb rm rmdir rmo rni rnp rp rsn rv rvpa sajb sal saps sasv sbp scb scim select set shcm si
sl sleep sls sort sp spjb spps spsv start stz sv tee type upmo where wjb write

# Cmdlets
Add-Content Add-History Add-Member Add-Type Clear-Content Clear-History Clear-Item Clear-ItemProperty Clear-RecycleBin
Clear-Variable Compare-Object Compress-Archive Connect-PSSession Connect-WSMan Convert-Path ConvertFrom-Csv
ConvertFrom-Json ConvertFrom-Markdown ConvertFrom-SddlString ConvertFrom-SecureString ConvertFrom-StringData
ConvertTo-Csv ConvertTo-Html ConvertTo-Json ConvertTo-SecureString ConvertTo-Xml Copy-Item Copy-ItemProperty Debug-Job
Debug-Process Debug-Runspace Disable-ExperimentalFeature Disable-PSBreakpoint Disable-PSRemoting
Disable-PSSessionConfiguration Disable-PSTrace Disable-PSWSManCombinedTrace Disable-RunspaceDebug Disable-WSManCredSSP
Disable-WSManTrace Disconnect-PSSession Disconnect-WSMan Enable-ExperimentalFeature Enable-PSBreakpoint
Enable-PSRemoting Enable-PSSessionConfiguration Enable-PSTrace Enable-PSWSManCombinedTrace Enable-RunspaceDebug
Enable-WSManCredSSP Enable-WSManTrace Enter-PSHostProcess Enter-PSSession Exit-PSHostProcess Exit-PSSession
Expand-Archive Export-Alias Export-Clixml Export-Csv Export-FormatData Export-ModuleMember Export-PSSession
Find-Command Find-DscResource Find-Module Find-Package Find-PackageProvider Find-RoleCapability Find-Script
ForEach-Object Format-Custom Format-Hex Format-List Format-Table Format-Wide Get-Acl Get-Alias
Get-AuthenticodeSignature Get-ChildItem Get-CimAssociatedInstance Get-CimClass Get-CimInstance Get-CimSession
Get-Clipboard Get-CmsMessage Get-Command Get-ComputerInfo Get-Content Get-Counter Get-Counter Get-Credential
Get-CredsFromCredentialProvider Get-Culture Get-Date Get-Error Get-Event Get-EventSubscriber Get-ExecutionPolicy
Get-ExperimentalFeature Get-FileHash Get-FormatData Get-Help Get-History Get-Host Get-HotFix Get-InstalledModule
Get-InstalledScript Get-Item Get-ItemProperty Get-ItemPropertyValue Get-Job Get-Location Get-LogProperties
Get-MarkdownOption Get-Member Get-Module Get-PSBreakpoint Get-PSCallStack Get-PSDrive Get-PSHostProcessInfo
Get-PSProvider Get-PSReadLineKeyHandler Get-PSReadLineOption Get-PSRepository Get-PSSession Get-PSSessionCapability
Get-PSSessionConfiguration Get-Package Get-PackageProvider Get-PackageSource Get-PfxCertificate Get-Process Get-Random
Get-Runspace Get-RunspaceDebug Get-Service Get-TimeZone Get-TraceSource Get-TypeData Get-UICulture Get-Unique
Get-Uptime Get-Variable Get-Verb Get-WSManCredSSP Get-WSManInstance Get-WinEvent Get-WinEvent Group-Object Import-Alias
Import-Clixml Import-Csv Import-LocalizedData Import-Module Import-PSSession Import-PackageProvider
Import-PowerShellDataFile Install-Module Install-Package Install-PackageProvider Install-Script Invoke-CimMethod
Invoke-Command Invoke-Expression Invoke-History Invoke-Item Invoke-RestMethod Invoke-WSManAction Invoke-WebRequest
Join-Path Join-String Measure-Command Measure-Object Move-Item Move-ItemProperty New-Alias New-CimInstance
New-CimSession New-CimSessionOption New-Event New-FileCatalog New-Guid New-Item New-ItemProperty New-Module
New-ModuleManifest New-Object New-PSDrive New-PSRoleCapabilityFile New-PSSession New-PSSessionConfigurationFile
New-PSSessionOption New-PSTransportOption New-ScriptFileInfo New-Service New-TemporaryFile New-TimeSpan New-Variable
New-WSManInstance New-WSManSessionOption New-WinEvent New-WinEvent Out-Default Out-File Out-GridView Out-Host Out-Null
Out-Printer Out-String PSConsoleHostReadLine Pop-Location Protect-CmsMessage Publish-Module Publish-Script
Push-Location Read-Host Receive-Job Receive-PSSession Register-ArgumentCompleter Register-CimIndicationEvent
Register-EngineEvent Register-ObjectEvent Register-PSRepository Register-PSSessionConfiguration Register-PackageSource
Remove-Alias Remove-CimInstance Remove-CimSession Remove-Event Remove-Item Remove-ItemProperty Remove-Job Remove-Module
Remove-PSBreakpoint Remove-PSDrive Remove-PSReadLineKeyHandler Remove-PSSession Remove-Service Remove-TypeData
Remove-Variable Remove-WSManInstance Rename-Computer Rename-Item Rename-ItemProperty Resolve-Path Restart-Computer
Restart-Service Resume-Service Save-Help Save-Module Save-Package Save-Script Select-Object Select-String Select-Xml
Send-MailMessage Set-Acl Set-Alias Set-AuthenticodeSignature Set-CimInstance Set-Clipboard Set-Content Set-Date
Set-ExecutionPolicy Set-Item Set-ItemProperty Set-Location Set-LogProperties Set-MarkdownOption Set-PSBreakpoint
Set-PSDebug Set-PSReadLineKeyHandler Set-PSReadLineOption Set-PSRepository Set-PSSessionConfiguration Set-PackageSource
Set-Service Set-StrictMode Set-TimeZone Set-TraceSource Set-Variable Set-WSManInstance Set-WSManQuickConfig
Show-Command Show-Markdown Sort-Object Split-Path Start-Job Start-Process Start-Service Start-Sleep Start-ThreadJob
Start-Trace Stop-Computer Stop-Job Stop-Process Stop-Service Stop-Trace Suspend-Service Tee-Object Test-Connection
Test-FileCatalog Test-Json Test-ModuleManifest Test-PSSessionConfigurationFile Test-Path Test-ScriptFileInfo Test-WSMan
Trace-Command Unblock-File Uninstall-Module Uninstall-Package Uninstall-Script Unprotect-CmsMessage Unregister-Event
Unregister-PSRepository Unregister-PSSessionConfiguration Unregister-PackageSource Update-FormatData Update-Help
Update-List Update-Module Update-ModuleManifest Update-Script Update-ScriptFileInfo Update-TypeData Wait-Debugger
Wait-Event Wait-Job Wait-Process Where-Object Write-Debug Write-Error Write-Host Write-Information Write-Output
Write-Progress Write-Verbose Write-Warning

