# Build Active Directoy

### Powershell Scripts for quick deployment (Push it via GPO when machine is newly joined)

#### Enable TLS 1.2 in powershell session
```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
```

#### Enable TLS 1.2 on client machine or Server
```powershell
If (-Not (Test-Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319'))
{
    New-Item 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319' -Force | Out-Null
}
New-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319' -Name 'SystemDefaultTlsVersions' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319'))
{
    New-Item 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -Force | Out-Null
}
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -Name 'SystemDefaultTlsVersions' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server'))
{
    New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Force | Out-Null
}
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Name 'Enabled' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Name 'DisabledByDefault' -Value '0' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client'))
{
    New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Force | Out-Null
}
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Name 'Enabled' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Name 'DisabledByDefault' -Value '0' -PropertyType 'DWord' -Force | Out-Null

Write-Host 'TLS 1.2 has been enabled. You must restart the Windows Server for the changes to take affect.' -ForegroundColor Cyan
```

#### Install 7zip

```powershell
$dlurl = 'https://7-zip.org/' + (Invoke-WebRequest -UseBasicParsing -Uri 'https://7-zip.org/' | Select-Object -ExpandProperty Links | Where-Object {($_.outerHTML -match 'Download')-and ($_.href -like "a/*") -and ($_.href -like "*-x64.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href)
# modified to work without IE
# above code from: https://perplexity.nl/windows-powershell/installing-or-updating-7-zip-using-powershell/
$installerPath = Join-Path $env:TEMP (Split-Path $dlurl -Leaf)
Invoke-WebRequest $dlurl -OutFile $installerPath
Start-Process -FilePath $installerPath -Args "/S" -Verb RunAs -Wait
Remove-Item $installerPath
```

#### Install notepad++ with latest version

```powershell
$LocalTempDir = $env:TEMP
$href = ((Invoke-WebRequest -Uri 'https://notepad-plus-plus.org/downloads/').Links | Where-Object { $_.innerText -match 'current version' }).href
$downloadUrl = ((Invoke-WebRequest "https://notepad-plus-plus.org/$href").Links | Where-Object { $_.innerHTML -match 'installer' -and $_.href -match 'x64.exe' }).href
Invoke-RestMethod $downloadUrl -OutFile "$LocalTempDir/np++.exe"
start-process -FilePath "$LocalTempDir\np++.exe" -ArgumentList '/S' -Verb runas -Wait
```


#### Install Chrome

```powershell
$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor = "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)
```

#### Install common AAD powershell modules

```powershell
Install-PackageProvider NuGet -Force

Set-PSRepository PSGallery -InstallationPolicy Trusted

Set-ExecutionPolicy RemoteSigned

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  
Install-Module Az -Force

Install-Module MSOnline -Force

Install-Module AzureAD -Force
```

#### Install Edge browser > Navigate to [Install Edge](https://www.microsoft.com/en-us/edge/download?form=MA13FJ) for manual download and installation

commands deprecated
```powershell
md -Path $env:temp\edgeinstall -erroraction SilentlyContinue | Out-Null
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$Download = join-path $env:temp\edgeinstall MicrosoftEdgeEnterpriseX64.msi
Invoke-WebRequest 'https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/a2662b5b-97d0-4312-8946-598355851b3b/MicrosoftEdgeEnterpriseX64.msi'  -OutFile $Download
Start-Process "$Download" -ArgumentList "/quiet"
```
![image](https://user-images.githubusercontent.com/96930989/227784354-b305d387-09c0-480c-bd10-aebb4ab1a835.png)


#### Install firefox
```powershell
# Define the URL for the Firefox full installer
$firefoxURL = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/93.0/win64/en-US/Firefox%20Setup%2093.0.exe"

# Define the path where the installer will be saved
$installerPath = "C:\Temp\FirefoxInstaller.exe"

# Create the directory if it doesn't exist
if (-Not (Test-Path "C:\Temp")) {
    New-Item -ItemType Directory -Path "C:\Temp"
}

# Download the Firefox full installer
Invoke-WebRequest -Uri $firefoxURL -OutFile $installerPath

# Install Firefox silently
Start-Process -FilePath $installerPath -Args "/S" -Wait

# Delete the installer
Remove-Item -Path $installerPath

# Confirm Installation
Write-Host "Firefox silent installation is complete."
```

#### Remove firefox
```powershell
# Look up the uninstall string for Firefox from the Windows Registry
$uninstallPath = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall  -Recurse |
Get-ItemProperty |
Where-Object {$_.DisplayName -match 'Mozilla Firefox'} |
Select-Object -Property DisplayName, UninstallString

# Check if Firefox is installed
if ($uninstallPath -eq $null) {
    Write-Host "Firefox is not installed on this machine."
} else {
    # Run the uninstaller
    Write-Host "Uninstalling Firefox..."
    Start-Process cmd -ArgumentList "/c $($uninstallPath.UninstallString) /S" -Wait
    Write-Host "Firefox has been uninstalled."
}
```

### Other commands

#### Join domain

On client machine ( going to be domain joined )

```powershell
Set-DNSClientServerAddress "<adapter name>" –ServerAddresses ("<IP of DC>")
```

Sample
```powershell
Set-DNSClientServerAddress "NIC1" –ServerAddresses ("192.168.2.50")
```

```powershell
Set-DNSClientServerAddress "Ethernet0" –ServerAddresses ("192.168.242.139")
```

Verify the DNS server you set
```powershell
Get-dnsclientserveraddress
```


#### Rename computer name


```powershell
Rename-Computer -NewName "<new computer name>" -Restart
```
Sample
```powershell
Rename-Computer -NewName "ADFS1" -Restart
```

### Join domain
```powershell
add-computer –domainname "<domain name>"  -restart
```

Smaple
```powershell
add-computer –domainname "acetest.com" -DomainCredential ace\administrator -restart
```

### Rename domain-joined machines

```powershell
Rename-Computer -NewName "<new computer name>" -DomainCredential <domain admin in SAM format> -Restart
```

Sample
```powershell
Rename-Computer -NewName "ACEADFS1" -DomainCredential ace\administrator -Restart
```

### Leave domain

```powershell
Remove-Computer -UnjoinDomaincredential <domain admin in SAM format> -PassThru -Verbose -Restart
```

Sample
```powershell
Remove-Computer -UnjoinDomaincredential Power\administrator -PassThru -Verbose -Restart
```




