### Import Edge GPO module

Some domain controller was built years ago wher the Edge is not indroduced, as a result, the GPO template does not contain the registry keys of Edge.
This article shows the steps to import `Edge` GPO module to your domain controller.

#### 1. Download Edge GPO module
Navigate to [Download Edge](https://www.microsoft.com/en-us/edge/business/download)

Select the `version` of Edge browser, the `operating system` of the machine

Click `GET POLICY FILES` and download `MicrosoftEdgePolicyTemplates`

![image](https://user-images.githubusercontent.com/96930989/211276445-0b7f5f29-de30-44e3-85ef-1507f50b577a.png)

#### 2. Install the `MicrosoftEdgePolicyTemplates`
![image](https://user-images.githubusercontent.com/96930989/211276581-c06811e2-c99b-436a-b3e6-c54a8744e9d3.png)

Extract the file

![image](https://user-images.githubusercontent.com/96930989/211276657-3549dd76-5b80-4a39-81a0-7b9699eaaa42.png)

#### 3. Configure Microsoft Edge policy settings
[Configure Microsoft Edge policy settings on Windows device](shttps://learn.microsoft.com/en-us/deployedge/configure-microsoft-edge)

Navigate to the path we just extracted `MicrosoftEdgePolicyTemplates`

Go to `MicrosoftEdgePolicyTemplates > Windows > admx`

Copy the `msedge.admx` file to the path 
```
C:\Windows\SYSVOL\domain\Policies\PolicyDefinitions
```
![image](https://user-images.githubusercontent.com/96930989/211277494-f523c3ab-e859-4e58-9e35-25008e8487a3.png)

In the `MicrosoftEdgePolicyTemplates > Windows > admx` folder, open the appropriate `language folder`.  

For example, if you prefer the language English, open the `en-US `folder.

Copy this `msedge.adml` file

![image](https://user-images.githubusercontent.com/96930989/211277566-6ed25c87-c26c-4fba-92bb-db2c3787dfed.png)

Paste the `msedge.adml` file to the `matching language folder` under path
```
C:\Windows\SYSVOL\domain\Policies\PolicyDefinitions\<language folder>
```

Note
```
Create the folder if it does not already exist
```
![image](https://user-images.githubusercontent.com/96930989/211278311-723d417a-b0f1-4b48-86bf-66fb5a14e28d.png)


#### 4. Confirm if the the Edge module has been imported successfully
To confirm the files loaded correctly, launch the `Group Policy Management Editor` from `Windows Administrative Tools`,

Then expand `Computer Configuration > Policies > Administrative Templates > Microsoft Edge`

You should see one or more Microsoft Edge nodes as shown below.

![image](https://user-images.githubusercontent.com/96930989/211278734-a395192a-d911-4fe5-a352-1dd7f42552c9.png)




