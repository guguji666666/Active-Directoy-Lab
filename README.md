# 🏗️ Build Active Directory Deployment Toolkit

> 💡 Recommended to **push via GPO** or other automation when a machine is newly joined to the domain.

---

## 🔐 Enable TLS 1.2

### Enable TLS 1.2 in PowerShell session (for current script use)

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
```

### Enable TLS 1.2 system-wide (client/server)

```powershell
# .NET Framework settings (32-bit)
$path1 = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319'
if (-not (Test-Path $path1)) { New-Item $path1 -Force | Out-Null }
New-ItemProperty -Path $path1 -Name 'SystemDefaultTlsVersions' -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path $path1 -Name 'SchUseStrongCrypto' -Value 1 -PropertyType DWord -Force

# .NET Framework settings (64-bit)
$path2 = 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319'
if (-not (Test-Path $path2)) { New-Item $path2 -Force | Out-Null }
New-ItemProperty -Path $path2 -Name 'SystemDefaultTlsVersions' -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path $path2 -Name 'SchUseStrongCrypto' -Value 1 -PropertyType DWord -Force

# TLS 1.2 Protocol for Server
$serverPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server'
if (-not (Test-Path $serverPath)) { New-Item $serverPath -Force | Out-Null }
New-ItemProperty -Path $serverPath -Name 'Enabled' -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path $serverPath -Name 'DisabledByDefault' -Value 0 -PropertyType DWord -Force

# TLS 1.2 Protocol for Client
$clientPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client'
if (-not (Test-Path $clientPath)) { New-Item $clientPath -Force | Out-Null }
New-ItemProperty -Path $clientPath -Name 'Enabled' -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path $clientPath -Name 'DisabledByDefault' -Value 0 -PropertyType DWord -Force

Write-Host '✅ TLS 1.2 has been enabled. Please restart the system to apply changes.' -ForegroundColor Cyan
```

---

## 🚀 Configure Static IP and DNS

```powershell
# Ensure script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrator")) {
    Write-Warning "⚠ Please run this script as Administrator!"
    exit
}

# Get current active network adapter
$adapter = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | Select-Object -First 1
$interfaceAlias = $adapter.Name

# Get current IP config
$ipConfig = Get-NetIPInterface -InterfaceAlias $interfaceAlias -AddressFamily IPv4

Write-Host "Detected adapter: $interfaceAlias"

# PowerShell does not support ternary operators, use if/else
$ipType = if ($ipConfig.Dhcp -eq "Enabled") { "Dynamic (DHCP)" } else { "Static" }
Write-Host "Current IP assignment: $ipType"

# Set Static IP
$setStaticIP = Read-Host "`nDo you want to manually set a static IP? (y/n)"
if ($setStaticIP -eq 'y') {
    $ipAddress = Read-Host "Enter IP address (e.g. 192.168.1.100)"
    $subnetMask = Read-Host "Enter subnet mask (e.g. 255.255.255.0)"
    $gateway = Read-Host "Enter default gateway (e.g. 192.168.1.1)"

    # Remove existing IPv4 addresses
    Get-NetIPAddress -InterfaceAlias $interfaceAlias -AddressFamily IPv4 | Remove-NetIPAddress -Confirm:$false

    # Calculate prefix length from subnet mask
    $prefixLength = 32 - [math]::Log(([ipaddress]$subnetMask).Address -band 0xffffffff + 1, 2)

    # Set static IP
    New-NetIPAddress -InterfaceAlias $interfaceAlias -IPAddress $ipAddress -PrefixLength $prefixLength -DefaultGateway $gateway
    Set-NetIPInterface -InterfaceAlias $interfaceAlias -Dhcp Disabled

    Write-Host "`n✅ Static IP configured."
} else {
    Write-Host "IP configuration unchanged."
}

# Set DNS
$setDNS = Read-Host "`nDo you want to manually set DNS servers? (y/n)"
if ($setDNS -eq 'y') {
    $primaryDNS = Read-Host "Enter primary DNS (e.g. 8.8.8.8)"
    $secondaryDNS = Read-Host "Enter secondary DNS (e.g. 8.8.4.4)"

    Set-DnsClientServerAddress -InterfaceAlias $interfaceAlias -ServerAddresses @($primaryDNS, $secondaryDNS)
    Write-Host "`n✅ DNS servers configured."
} else {
    Write-Host "DNS settings unchanged."
}
```
Sample <br>
![image](https://github.com/user-attachments/assets/d544cc24-bedf-4455-96bc-8686c744c9c1)


---

## 💻 Enable RDP & Configure Access Control

```powershell
# Display domain name
$domain = ([System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()).Name
Write-Host "\n🖥️ Current domain: $domain"

# Enable Remote Desktop
$enableRDP = Read-Host "\nEnable Remote Desktop (RDP)? (y/n)"
if ($enableRDP -eq 'y') {
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    Write-Host "✅ Remote Desktop enabled and firewall rules adjusted."
} else {
    Write-Host "➡ No changes made to Remote Desktop settings."
}

# Add authorized RDP users or groups
$addRDPUser = Read-Host "\nAdd authorized RDP user or group? (y/n)"
if ($addRDPUser -eq 'y') {
    $choice = Read-Host "Enter type (group or user)"

    if ($choice -eq 'group') {
        $groupInput = Read-Host "Enter group name (domain\\group or just group name)"
        $groupSAM = if ($groupInput -like "*\\*") { $groupInput } else { "$domain\\$groupInput" }

        try {
            $groupExists = ([ADSI]"WinNT://$groupSAM,group").Name
            if ($groupExists) {
                Add-LocalGroupMember -Group "Remote Desktop Users" -Member $groupSAM -ErrorAction Stop
                Write-Host "✅ Group $groupSAM added to Remote Desktop Users."
            }
        } catch {
            Write-Warning "❌ Group not found or format invalid: $groupSAM"
        }

    } elseif ($choice -eq 'user') {
        $userInput = Read-Host "Enter username (User or Domain\\User)"
        $userSAM = if ($userInput -like "*\\*") { $userInput } else { "$domain\\$userInput" }

        try {
            $userExists = ([ADSI]"WinNT://$userSAM,user").Name
            if ($userExists) {
                Add-LocalGroupMember -Group "Remote Desktop Users" -Member $userSAM -ErrorAction Stop
                Write-Host "✅ User $userSAM added to Remote Desktop Users."
            }
        } catch {
            Write-Warning "❌ User not found or format invalid: $userSAM"
        }

    } else {
        Write-Warning "⚠ Invalid input. Must be 'group' or 'user'."
    }
} else {
    Write-Host "➡ No changes made to RDP user access."
}
```


## 📦 Common Software Installers

### Install 7-Zip (x64)

```powershell
$dlurl = 'https://7-zip.org/' + (Invoke-WebRequest -UseBasicParsing -Uri 'https://7-zip.org/' |
    Select-Object -ExpandProperty Links |
    Where-Object { $_.outerHTML -match 'Download' -and $_.href -like "a/*" -and $_.href -like "*-x64.exe" } |
    Select-Object -First 1 |
    Select-Object -ExpandProperty href)

$installerPath = Join-Path $env:TEMP (Split-Path $dlurl -Leaf)
Invoke-WebRequest $dlurl -OutFile $installerPath
Start-Process -FilePath $installerPath -Args "/S" -Verb RunAs -Wait
Remove-Item $installerPath
```

### Install Notepad++ (latest version)

```powershell
$LocalTempDir = $env:TEMP
$href = ((Invoke-WebRequest -Uri 'https://notepad-plus-plus.org/downloads/').Links | Where-Object { $_.innerText -match 'current version' }).href
$downloadUrl = ((Invoke-WebRequest "https://notepad-plus-plus.org/$href").Links | Where-Object { $_.innerHTML -match 'installer' -and $_.href -match 'x64.exe' }).href
Invoke-RestMethod $downloadUrl -OutFile "$LocalTempDir\np++.exe"
Start-Process "$LocalTempDir\np++.exe" -ArgumentList '/S' -Verb runas -Wait
```

### Install Google Chrome

```powershell
$LocalTempDir = $env:TEMP
$ChromeInstaller = "ChromeInstaller.exe"
(New-Object System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller")
& "$LocalTempDir\$ChromeInstaller" /silent /install
Do {
    $ProcessesFound = Get-Process | Where-Object { $_.Name -eq "ChromeInstaller" }
    if ($ProcessesFound) { Start-Sleep -Seconds 2 }
    else { Remove-Item "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue }
} Until (!$ProcessesFound)
```

### Install Microsoft Edge

➡️ Visit: [Download Edge](https://www.microsoft.com/en-us/edge/download?form=MA13FJ)

*⚠️ MSI Installer method deprecated*

### Install Firefox (v93.0 Example)

```powershell
$firefoxURL = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/93.0/win64/en-US/Firefox%20Setup%2093.0.exe"
$installerPath = "C:\Temp\FirefoxInstaller.exe"

if (-Not (Test-Path "C:\Temp")) {
    New-Item -ItemType Directory -Path "C:\Temp"
}

Invoke-WebRequest -Uri $firefoxURL -OutFile $installerPath
Start-Process $installerPath -Args "/S" -Wait
Remove-Item $installerPath

Write-Host "✅ Firefox silent installation complete."
```

### Uninstall Firefox

```powershell
$uninstallPath = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall -Recurse |
    Get-ItemProperty |
    Where-Object { $_.DisplayName -match 'Mozilla Firefox' } |
    Select-Object -First 1

if ($null -eq $uninstallPath) {
    Write-Host "Firefox is not installed."
} else {
    Start-Process cmd -ArgumentList "/c $($uninstallPath.UninstallString) /S" -Wait
    Write-Host "✅ Firefox uninstalled."
}
```

---

## ⚙️ Install Common PowerShell Modules

```powershell
Install-PackageProvider NuGet -Force
Set-PSRepository PSGallery -InstallationPolicy Trusted
Set-ExecutionPolicy RemoteSigned
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Install-Module Az -Force
Install-Module MSOnline -Force
Install-Module AzureAD -Force
```

---

## 🖥️ Domain Operations

### Set DNS Client Address

```powershell
Set-DNSClientServerAddress "<adapter name>" –ServerAddresses ("<DC IP>")
```

**Examples:**

```powershell
Set-DNSClientServerAddress "NIC1" –ServerAddresses ("192.168.2.50")
Set-DNSClientServerAddress "Ethernet0" –ServerAddresses ("192.168.242.139")
```

### Verify DNS

```powershell
Get-DnsClientServerAddress
```

### Rename Computer

```powershell
Rename-Computer -NewName "<new name>" -Restart
# Example:
Rename-Computer -NewName "ADFS1" -Restart
```

### Join Domain

```powershell
# Ensure script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrator")) {
    Write-Warning "⚠ Please run this script as Administrator!"
    exit
}

# Prompt for domain name
$domainName = Read-Host "Enter the domain name you want to join (e.g. acetest.com)"

# Prompt for domain credential securely
Write-Host "Please enter credentials to join domain $domainName..."
$domainCred = Get-Credential -Message "Enter Domain Admin credentials (e.g. ace\\administrator)"

# Attempt to join domain
try {
    Add-Computer -DomainName $domainName -Credential $domainCred -Force
    Write-Host "`n✅ Successfully joined domain: $domainName" -ForegroundColor Green
} catch {
    Write-Error "❌ Failed to join domain: $_"
    exit
}

# Ask if user wants to rename the machine
$rename = Read-Host "`nDo you want to rename this computer before restart? (y/n)"
if ($rename -eq 'y') {
    $newName = Read-Host "Enter the new computer name"
    try {
        Rename-Computer -NewName $newName -Force -DomainCredential $domainCred
        Write-Host "✅ Successfully renamed to $newName" -ForegroundColor Green
    } catch {
        Write-Error "❌ Failed to rename computer: $_"
        exit
    }
}

# Restart to apply changes
Write-Host "`nThe machine will now restart to apply domain changes..." -ForegroundColor Cyan
Restart-Computer -Force
```

### Rename Domain-Joined Machine

```powershell
Rename-Computer -NewName "<new name>" -DomainCredential <SAM format> -Restart
# Example:
Rename-Computer -NewName "ACEADFS1" -DomainCredential ace\administrator -Restart
```

### Leave Domain

```powershell
Remove-Computer -UnjoinDomaincredential <domain admin> -PassThru -Verbose -Restart
# Example:
Remove-Computer -UnjoinDomaincredential Power\administrator -PassThru -Verbose -Restart
```

---

### 📸 Visual Reference

![TLS Settings](https://user-images.githubusercontent.com/96930989/227784354-b305d387-09c0-480c-bd10-aebb4ab1a835.png)

---
