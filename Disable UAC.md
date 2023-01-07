## Option 1 : Disable UAC via UI on local machine (non domain-joined)

1. Type uac into the Windows Start menu.
![image](https://user-images.githubusercontent.com/96930989/210131956-205f4746-1b54-46e6-9e16-7ced5e5f585d.png)

2. Click "Change User Account Control settings."

3. Move the slider down to "Never Notify."
![image](https://user-images.githubusercontent.com/96930989/210131957-4ec67355-a9ca-47b0-9e0d-5bfc61d79558.png)

4. Click OK and then restart the computer.


## Option 2 : Disable UAC via powershell locally (non domain-joined)

Disable UAC : The command only closes the prompt for UAC, the user still doesn't have administrator permissions.
```cmd
%windir%\System32\cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
```

Command to enable UAC if needed
```cmd
%windir%\System32\cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
```

## Option 3 : For domain joined devices , using GPO for bulk management

Link : [Disable User Account Control Using Group Policy](https://www.prajwaldesai.com/disable-user-account-control-using-group-policy/)

GPO path : `Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options`

![image](https://user-images.githubusercontent.com/96930989/210132027-7bfbf233-7ce4-4d0a-a551-c0edbcd8b7cf.png)
