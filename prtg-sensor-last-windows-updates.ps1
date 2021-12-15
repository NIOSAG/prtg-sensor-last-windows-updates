<#
.SYNOPSIS
Outputs a PRTG XML structure with information about the last installed Windows Updates

.DESCRIPTION
Get Days since the last installed Windows Updates and displays the latest Windows Update

.INSTRUCTIONS
1) Copy the script file into the PRTG Custom EXEXML sensor directory C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML
        - prtg-sensor-last-windows-updates.ps1 (PowerShell Sensor Script)
3) Create Sensor Custom EXE/ Script Advanced Sensor for each sensor you wish to monitor (refer Scope) and give it a meaniful name
4) Set Parameters for sensor
    - (Host) Target Windows Host DNS name or IP address
    - (Username) and (Password) to gain access 
   e.g. -host %host -username %windowsuser -password "%windowspassword"

.NOTES
Authors: claudio.stocker@nios.ch, silvan.fleischli@nios.ch 
Website: https://nios.ch/
Version: 1.1
Date: 15.12.2021

.PARAMETER URL
FQDN or IP address of the target Windows server running

.PARAMETER UserName
The name of the account to be used to access the Windows server

.PARAMETER Password
The password of the account 

.EXAMPLES
C:\PS>prtg-sensor-last-windows-updates.ps1 -host server01 -username Administrator -password TopSecretPW

#>
param
(
	 [string]$hostname,
	 [string]$username,
	 [string]$password
)

$creds = New-Object System.Management.Automation.PSCredential ($username, (ConvertTo-SecureString $password -AsPlainText -Force))

$lasthotfix = (Get-WmiObject -Query "SELECT * FROM win32_quickfixengineering" -ComputerName $hostname -Credential $creds) | Select-Object description,hotfixid,installedby,
@{l="InstalledOn";e={
[DateTime]::Parse($_.psbase.properties["installedon"].value,
$([System.Globalization.CultureInfo]::GetCultureInfo("en-US")))}} | Sort-Object InstalledOn | Select -Last 1

Write-Host "<prtg>"
    Write-Host "<result>"
        Write-Host "<channel>DaysSinceLastHotfixInstalled</channel>"
        Write-Host "<value>$(((get-Date)-$lasthotfix.InstalledOn).Days)</value>"
        Write-Host "<LimitMode>1</LimitMode>"
        Write-Host "<LimitMaxError>90</LimitMaxError>"
        Write-Host "<LimitMaxWarning>60</LimitMaxWarning>"
    Write-Host "</result>"
    Write-Host "<text>Last Update: $($lasthotfix.hotfixid)</text>"
Write-Host "</prtg>"