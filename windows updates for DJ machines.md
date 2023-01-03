# Configure auto updates for windows
https://learn.microsoft.com/de-de/security-updates/windowsupdateservices/18127451#configure-automatic-updates


## GPO path
```
Computer Configuration > Administrative Templates > Windows Components > click Windows Update
```

### Click Enabled and select one of the following options:

#### 1. Notify for download and notify for install.
```
This option notifies a logged-on administrative user prior to the download and prior to the installation of the updates.
```

#### 2. Auto download and notify for install. 
```
This option automatically begins downloading updates and then notifies a logged-on administrative user prior to installing the updates.
```

#### 3. Auto download and schedule the install. 
```
If Automatic Updates is configured to perform a scheduled installation, you must also set the day and time for the recurring scheduled installation.
```

#### 4. Allow local admin to choose setting. 
```
With this option, the local administrators are allowed to use Automatic Updates in Control Panel to select a configuration option of their choice. For example, they can choose their own scheduled installation time. Local administrators are not allowed to disable Automatic Updates.
```

![image](https://user-images.githubusercontent.com/96930989/210132219-6e686617-dd78-46fe-8bc8-bf7ad095ffc2.png)
