# Enable Hyper-V on windows clients

## Windows 10
https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v

#### Requirements
```
Windows 10 Enterprise, Pro, or Education
64-bit Processor with Second Level Address Translation (SLAT).
CPU support for VM Monitor Mode Extension (VT-c on Intel CPUs).
Minimum of 4 GB memory.
```

Open a PowerShell console as Administrator.
```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```
When the installation has completed, reboot the machine


## Windows 11
https://pureinfotech.com/enable-hyper-v-windows-11/

Open a PowerShell console as Administrator.
```powershell
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
```
Type Y to restart your computer.
