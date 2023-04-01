# Push powershell scripts to AD machines on startup only `once`

## Create shared folder to store powershell scripts

### 1. Create a new folder on DC
![image](https://user-images.githubusercontent.com/96930989/211191621-cff1dda4-e591-41b5-8725-bfbab672b1d0.png)

### 2. Make it shared folder
![image](https://user-images.githubusercontent.com/96930989/211191637-33587410-944a-4559-a621-503ce04430a4.png)

### 3. Define the permission of `Users & Computer objects` on this shared folder
![image](https://user-images.githubusercontent.com/96930989/211191666-af604dde-ecda-4c5a-9a88-9525eb004915.png)

### 4. Note the `Network Path` generated for this shared folder , we will need it later.
![image](https://user-images.githubusercontent.com/96930989/211191691-c5234512-64fd-4101-8c6e-0c17e58a41d3.png)

Sample : `\\WIN-EVUDHQG2VII\SharedFile`

## Create powershell scripts and bat files (used to call powershell exe)

### 1. Paste the powershell script there
![image](https://user-images.githubusercontent.com/96930989/211191792-bcd554e8-ce5e-4c6e-8190-a2ade020101b.png)

Note the `network path` of these powershell scripts

Sample:
```sh
\\WIN-EVUDHQG2VII\SharedFile\Chrome.ps1
\\WIN-EVUDHQG2VII\SharedFile\TLS1.2.ps1
```

### 2. Create `bat` file that calls powershell exe

Create a new txt file.

Paste context below in the txt file.
```sh
powershell.exe -executionpolicy ByPass -file "<network path of the powershell script>"
```

Sample
```sh
powershell.exe -executionpolicy ByPass -file "\\WIN-EVUDHQG2VII\SharedFile\TLS1.2.ps1"
powershell.exe -executionpolicy ByPass -file "\\WIN-EVUDHQG2VII\SharedFile\Chrome.ps1"
```

Save the `txt` file, modify the `extension` of txt file to be `bat` file
![image](https://user-images.githubusercontent.com/96930989/211191932-674922fc-8f18-4bc6-a2d5-d59468a5f915.png)

Note the `network path` of this `bat` file

Sample

```sh
\\WIN-EVUDHQG2VII\SharedFile\Chrome.bat
\\WIN-EVUDHQG2VII\SharedFile\TLS1.2.bat
```

### 3. Create GPO to push bat files that triggers powershell scripts

Log in to a `domain controller` as enterprise/domain admin, launch Group Policy Management Console

Create a new GPO object


#### If GPO is supposed to be linked to OU that contains `Machine objects`

Navigate to `Computer configuration > Preferences > Control Panel Settings > Scheduled Task`

Right click it `New > Immediate Task ( At least Windows 7)`

![image](https://user-images.githubusercontent.com/96930989/211192094-1b6e1185-f6c3-4a2d-8eab-3a5f3a1c02bb.png)

#### If GPO is supposed to be linked to OU that contains `User objects`

Navigate to `User configuration > Preferences > Control Panel Settings > Scheduled Task`

Right click it `New > Immediate Task ( At least Windows 7)`

![image](https://user-images.githubusercontent.com/96930989/211192152-05688d03-a1b9-4fdf-9117-af1d421f4bac.png)

Modify the settings following the picture below 

![image](https://user-images.githubusercontent.com/96930989/211192175-a0c5f849-a0f9-4fce-8c9c-42cd54a170d4.png)

Go to `Actions > New`

![image](https://user-images.githubusercontent.com/96930989/211192185-09abd4a8-6b4e-4170-a830-b86be56cc3ee.png)

Paste the network path of `bat` file we created before , and click `Ok`

![image](https://user-images.githubusercontent.com/96930989/211192201-72153fd4-2320-41f6-bf28-d82e10a8a74b.png)

Check the box of `Apply once and do not reapply`, then `Apply`, `OK`

![image](https://user-images.githubusercontent.com/96930989/211192235-76dcc769-2896-49a8-a583-a9f7462aa946.png)

Save the GPO object and link it to the OU you want to connect

Then you can log out and log in the machines to apply that new GPO if required.

