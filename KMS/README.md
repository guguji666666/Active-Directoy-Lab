# Build KMS host
[How to create a Key Management Services (KMS) activation host](https://learn.microsoft.com/en-us/windows-server/get-started/kms-create-host)

[Youtube tutorial to build KMS server(Chinese)](https://www.youtube.com/watch?v=L1YNqxhZBp0)

# KMS keys from Microsoft

[(KMS) client activation and product keys](https://learn.microsoft.com/en-us/windows-server/get-started/kms-client-activation-keys)


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


## Commands to activate `Windows server` (run cmd as administrator)
#### 1. To remove any existing product key (in case you used a trial key),
```sh
slmgr.vbs /upk
```
![image](https://user-images.githubusercontent.com/96930989/211156590-1ae96886-697a-443b-9e45-394b5b105b6d.png)

#### 2. Clear the product key from registry
```sh
slmgr.vbs /cpky
```
![image](https://user-images.githubusercontent.com/96930989/211155694-b4d51e6b-66a1-456a-9937-48bff4104086.png)

#### 3. Get current edition
```sh
Dism /Online /Get-CurrentEdition
```

Sample for windows server

![image](https://user-images.githubusercontent.com/96930989/210148047-fddc4de4-0faf-462e-872c-1fbf7b47e5ce.png)

If you want to check the list of Windows editions that an image `can be changed to` ,run the command below:
```sh
Dism /Online /Get-TargetEditions
```
![image](https://user-images.githubusercontent.com/96930989/211176560-e1e9edd3-d168-4b29-8332-3e30927eb38e.png)

More details could be found in [Get Windows Editions](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism-windows-edition-servicing-command-line-options?view=windows-11#get-currentedition)

#### 4. Define the IP of KMS server
```sh
slmgr -skms <ip of kms server>
```
![image](https://user-images.githubusercontent.com/96930989/211155820-5e4cb75e-bb30-4942-9589-999418c11d2d.png)

#### 5. Set the key according to the Edition of the OS

```sh
Dism /online /Set-Edition:serverstandard /AcceptEula /ProductKey:<KMS key that fits your server OS> 
```

Input `Y` when the process completes to reboot the machine.

Sample for Windows Server 2022
![image](https://user-images.githubusercontent.com/96930989/211176641-0f463b86-4db2-4baf-9d62-7c61394c8c6b.png)

#### 6. Go to activation settings, check if the server has been activated

Sample for Windows server 2022
![image](https://user-images.githubusercontent.com/96930989/211156234-6706cb20-9637-407b-85bc-84538e36a8f3.png)



## Commands to activate `Windows client` (run cmd as administrator)

#### 1. To remove any existing product key (in case you used a trial key),
```sh
slmgr.vbs /upk
```
![image](https://user-images.githubusercontent.com/96930989/211156590-1ae96886-697a-443b-9e45-394b5b105b6d.png)

#### 2. Clear the product key from registry
```sh
slmgr.vbs /cpky
```
![image](https://user-images.githubusercontent.com/96930989/211155694-b4d51e6b-66a1-456a-9937-48bff4104086.png)

#### 3. Get current edition
```sh
Dism /Online /Get-CurrentEdition
```

Sample

![image](https://user-images.githubusercontent.com/96930989/211156625-06efea65-c550-4360-9d61-d17ceb1fb5c2.png)

    
If you want to check the list of Windows editions that an image `can be changed to` ,run the command below:
```sh
Dism /Online /Get-TargetEditions
```

More details could be found in [Get Windows Editions](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism-windows-edition-servicing-command-line-options?view=windows-11#get-currentedition)


#### 4. Define the IP of KMS server
```sh
slmgr -skms <ip of kms server>
```

Sample for Windows 10 Pro

![image](https://user-images.githubusercontent.com/96930989/211155820-5e4cb75e-bb30-4942-9589-999418c11d2d.png)

#### 5. Set the activation key
```sh
slmgr -ipk <KMS key that fits your client OS>
```

Sample for Windows 10 Pro

![image](https://user-images.githubusercontent.com/96930989/211156865-e1e1baed-0e2b-4e82-84cc-cca645fb3bd0.png)


#### 6. Execute the activation
```sh
slmgr /ato
```
Sample for Windows 10 Pro

![image](https://user-images.githubusercontent.com/96930989/211157009-95e99508-a975-4046-a338-3230c7d8801b.png)

#### 7. Reboot the client/server
#### 8. Go to activation settings, check if the client has been activated

Sample for Windows 10 Pro

![image](https://user-images.githubusercontent.com/96930989/211157076-d251602e-34b6-4e16-9fb0-6abd3556ee64.png)

