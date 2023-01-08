# Powershell commands to modify network settings
[Configuring Network Adapter Settings with PowerShell: IP Address, DNS, Default Gateway, Static Routes](https://askme4tech.com/how-configure-network-adapter-powershell)
## 1. Get all netadpters with the interface name, state (Up/Down), MAC address and port speed.
```powershell
Get-NetAdapter
```
![image](https://user-images.githubusercontent.com/96930989/211178571-de263029-98f3-4b50-9734-4cfa2cbb1159.png)

## 2. You can change the adapter name
```powershell
Rename-NetAdapter -Name <current name of adapter> -NewName <the name you want to use>
```
Sample

Rename-NetAdapter -Name Ethernet0 -NewName LAN

## 3. View TCP/IP Network Adapter Settings
```powershell
Get-NetIPConfiguration -InterfaceAlias <name of adapter>
```
or
```powershell
Get-NetIPConfiguration -InterfaceAlias <name of adapter> -Detailed
```

## 3. Change Network Adapter from `DHCP` to `Static IP` Address

Remove existing static IP address
```powershell
Remove-NetIPAddress -InterfaceAlias <name of the adapter>
```
![image](https://user-images.githubusercontent.com/96930989/211179599-cd5bd8b8-2fc8-414e-90df-1fdbbc8b59f0.png)


Check if the IP has been removed successfully
```powershell
Get-NetIpAddress -InterfaceAlias <name of the adapter>
```

Set new static IP
```powershell
New-Netipaddress -InterfaceAlias <name of the adapter> -IpAddress <Ip you want to assign>
```

## 4. Change Network Adapter from `Static IP` Address to `DHCP`

Check existing static IP address
```powershell
Get-NetIpAddress -InterfaceAlias <name of the adapter>
```

Remove existing static IP address
```powershell
Remove-NetIPAddress -InterfaceAlias <name of the adapter>
```
![image](https://user-images.githubusercontent.com/96930989/211179599-cd5bd8b8-2fc8-414e-90df-1fdbbc8b59f0.png)

## 5. Change the Default Gateway of the Network Adapter

Check current gateway configured
```powershell
Get-netroute -InterfaceAlias <name of the adapter>
```
![image](https://user-images.githubusercontent.com/96930989/211179739-d5f0ab8f-6991-449b-bbd2-f17dba603198.png)

Remove existing gateway setting
```powershell
Remove-NetRoute -InterfaceAlias <name of the adapter> -DestinationPrefix 0.0.0.0/0 -NextHop <IP of existing gateway>
```

Set new gateway
```powershell
New-NetRoute -InterfaceAlias <name of the adapter> -DestinationPrefix 0.0.0.0/0 -NextHop <IP of new gateway>
```


## 5. Set Primary and Secondary DNS Server Addresses
```powershell
Set-DNSClientServerAddress -InterfaceAlias <name of adpater> -ServerAddresses <IP addresses used for DNS>
```

Sample:

Set-DNSClientServerAddress -InterfaceAlias Ethernet0 -ServerAddresses 223.5.5.5,223.6.6.6



