# Steps to update GPO template

### 1. Download the latest version of administrative template (central store)
[How to create and manage the Central Store for Group Policy Administrative Templates in Windows](https://learn.microsoft.com/en-US/troubleshoot/windows-client/group-policy/create-and-manage-central-store)

### 2. Install the new administrative template you just downloaded
Default installation path
```
C:\Program Files (x86)\Microsoft Group Policy
```
![image](https://user-images.githubusercontent.com/96930989/211255480-8b994403-2603-41f7-9b8e-103e0dfff358.png)

### 3. Create the folder to store GPO templates
Navigate to path:
```
C:\Windows\SYSVOL\domain\Policies
```
Create a new folder named `PolicyDefinitions`

![image](https://user-images.githubusercontent.com/96930989/211255624-f6ff0cb9-eb89-4d2c-8a01-f8de813c3578.png)

### 4. Replace the GPO files with new ones

Copy all the files `from` the path
```
C:\Program Files (x86)\Microsoft Group Policy\Windows 10 xxxxxxxxx\PolicyDefinitions
```
`To` path
```
C:\Windows\SYSVOL\domain\Policies\PolicyDefinitions
```
![image](https://user-images.githubusercontent.com/96930989/211255862-73fc24d4-c5c9-489b-a8e8-a955f43acc7d.png)

### 5. Check if the GPO template has been updated successfully
Navigate to `Group Policy Management Editor` on Domain controller

![image](https://user-images.githubusercontent.com/96930989/211258382-161c687a-b93c-4b10-9a9a-e40f34baa6d6.png)

![image](https://user-images.githubusercontent.com/96930989/211258389-4b141c3f-7d05-45a5-8171-9aaa8be8454b.png)


