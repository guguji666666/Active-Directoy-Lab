# Powershell commands to modify network settings
[Configuring Network Adapter Settings with PowerShell: IP Address, DNS, Default Gateway, Static Routes](https://woshub.com/powershell-configure-windows-networking/)
## 1. Get all netadpters with the interface name, state (Up/Down), MAC address and port speed.
```powershell
Get-NetAdapter
```
![image](https://user-images.githubusercontent.com/96930989/211178571-de263029-98f3-4b50-9734-4cfa2cbb1159.png)

## 2. You can change the adapter name
```powershell
Rename-NetAdapter -Name Ethernet0 -NewName LAN
```

## 3. View TCP/IP Network Adapter Settings
```powershell
Get-NetIPConfiguration -InterfaceAlias <name of adapter>
```
or
```powershell
Get-NetIPConfiguration -InterfaceAlias <name of adapter> -Detailed
```

## 3. To disable/enable obtaining an IP address from DHCP for your adapter, run the command:
Disable DHCP
```powershell
Set-NetIPInterface -InterfaceAlias <name of adapter> -Dhcp Disabled
```

Enable DHCP
```powershell
Set-NetIPInterface -InterfaceAlias <name of adapter> -Dhcp Enabled
```

## 4. Using PowerShell to Set Static IP Address
```powershell
New-NetIPAddress –IPAddress <the ip you want to assign> -DefaultGateway <ip of gateway> -PrefixLength 24 -InterfaceIndex 8
```

## 5. Set Primary and Secondary DNS Server Addresses
```powershell
Set-DNSClientServerAddress –<name of adpater> –ServerAddresses <IP addresses used for DNS>
```

Sample:

Set-DNSClientServerAddress –InterfaceIndex 8 –ServerAddresses 192.168.2.11,10.1.2.11



