## How to install Win11 on `unsupported` hardware (ESXI8 in this article)

1. Press `Shift + F10` keyboard shortcut to open Command Prompt.

2. Type the following command and press Enter:
```
regedit
```

![image](https://user-images.githubusercontent.com/96930989/211143957-4e4d6391-c4ee-45ab-9a99-110d7eaeca50.png)

3. Navigate the following path:
```
HKEY_LOCAL_MACHINE\SYSTEM\Setup
```
4. Right-click the `Setup` (folder) key, select `New`, and then the `Key` option.

![image](https://user-images.githubusercontent.com/96930989/211144174-abcfba6f-fddf-41f8-9d5e-4ff39d32f026.png)

5. Name the key `LabConfig` and press Enter.

6. Right-click the `LabConfig` (folder) key, select `New`, and then the `DWORD (32-bit)` Value option.

7. Name the key `BypassTPMCheck` and press Enter.

8. Double-click the newly created key and set its value `from 0 to 1`.

![image](https://user-images.githubusercontent.com/96930989/211144203-621e5e83-18b0-4dac-b66b-13d2d6c39a8b.png)

9. Click the OK button.

10. Right-click the `LabConfig` (folder) key, select `New`, and then the `DWORD (32-bit)` Value option.

11. Name the DWORD `BypassSecureBootCheck` and press Enter.

12. Double-click the newly created key and set its value `from 0 to 1`.

![image](https://user-images.githubusercontent.com/96930989/211144233-534456e1-787b-4bd4-820c-e1cf915b3def.png)

13. Click the OK button.

14. Then you can go ahead to install Win11 on this machine.

