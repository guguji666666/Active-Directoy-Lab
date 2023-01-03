# KMS host build up
```
https://learn.microsoft.com/en-us/windows-server/get-started/kms-create-host
https://www.youtube.com/watch?v=L1YNqxhZBp0
```

# KMS keys from Microsoft
```
https://learn.microsoft.com/en-us/windows-server/get-started/kms-client-activation-keys
```

## Windows Server 2022
```
Windows Server 2022 - Datacenter
WX4NM-KYWYW-QJJR4-XV3QB-6VM33
```
```
Windows Server 2022 - Standard	
VDYBN-27WPP-V4HQT-9VMD4-VMK7H
```


## Windows Server 2019
```
Windows Server 2019 Datacenter
WMDGN-G9PQG-XVVXX-R3X43-63DFG
```
```
Windows Server 2019 Standard
N69G4-B89J2-4G8F4-WWYCC-J464C
```
```
Windows Server 2019 Essentials
WVDHN-86M7X-466P6-VHXV7-YY726
```


## Windows Server 2016
```
Windows Server 2016 Datacenter
CB7KF-BWN84-R7R2Y-793K2-8XDDG
```
```
Windows Server 2016 Standard
WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY
```
```
Windows Server 2016 Essentials
JCKRF-N37P4-C2D82-9YXRT-4M63B
```

## Windows Client OS
```
Windows 10/11 Pro                              W269N-WFGWX-YVC9B-4J6C9-T83GX
Windows 10/11 Pro N                            MH37W-N47XK-V7XM9-C7227-GCQG9
Windows 10/11 Pro for Workstations             NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J
Windows 10/11 Pro for Workstations N	       9FNHH-K3HBT-3W4TD-6383H-6XYWF
Windows 10/11 Pro Education                    6TP4R-GNPTD-KYYHQ-7B7DP-J447Y
Windows 10/11 Pro Education N                  YVWGF-BXNMC-HTQYQ-CPQ99-66QFC
Windows 10/11 Education                        NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
Windows 10/11 Education N                      2WH4N-8QGBV-H22JP-CT43Q-MDWWJ
Windows 10/11 Enterprise	               NPPR9-FWDCX-D2C8J-H872K-2YT43
Windows 10/11 Enterprise N                     DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4
Windows 10/11 Enterprise G                     YYVX9-NTFWV-6MDM3-9PT4T-4M68B
Windows 10/11 Enterprise G N                   44RPN-FTY23-9VTTB-MP9BX-T84FV
```


## Steps to activate via KMS keys
#### 1. To remove any existing product key (in case you used a trial key),
```sh
slmgr.vbs /upk
```
#### 2. Clear the product key from registry
```sh
slmgr.vbs /cpky
```
#### 3. Reboot the client/server
#### 4. Get current edition
```sh
Dism /Online /Get-CurrentEdition
```
   
![image](https://user-images.githubusercontent.com/96930989/210148047-fddc4de4-0faf-462e-872c-1fbf7b47e5ce.png)
    
```
Reference link
https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism-windows-edition-servicing-command-line-options?view=windows-11#get-currentedition
```

#### 5. Define the IP of KMS server
```sh
slmgr -skms <ip of kms server>
```

#### 6. Set the Edition of the OS
```sh
Dism /online /Set-Edition:<edition name> /AcceptEula /ProductKey:<KMS key that fits your client/server OS> 
```
#### 7. Apply the activation key
```sh
slmgr -ipk <KMS key that fits your client/server OS>
```
#### Then,
```sh
slmgr /ato
```










