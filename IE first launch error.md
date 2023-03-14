## Error message
#### The response content cannot be parsed because the Internet Explorer engine is not available, or Internet Explorer’s first-launch configuration is not complete. Specify the UseBasicParsing parameter and try again.
#### Solution
##### Local/Domain GPO path
```
Computer Configuration > Policies > Administrative Templates > Windows Components > Internet Explorer
```
Select `go directly to home page`
![image](https://user-images.githubusercontent.com/96930989/224661914-5b8cac38-db98-4974-b03b-885dfbf8d2b9.png)

Run powershell command on domain joined machine
```cmd
gpupdate /force
```
