## Deploy X-UI on Azure VM running CentOS7
### [Video tutorial](https://www.youtube.com/watch?v=KGy4OMl02u8)
### Before we start
1. Make sure you have a custom domain
2. Add DNS `A` record in your DNS provider, point `FQDN` to your Azure VM's IP
```
For example,
You bought Domain "abc.com" from DNS provider.
Then you create FQDN "test.abc.com" for your Azure VM.
DNS A record > points "test.abc.com" to the IP of Azure VM.
```
3. How to get your custom domain
* [Get custom domain from Aliyun](https://wanwang.aliyun.com/domain/)

* [Manage your custom domain in Aliyun](https://account.aliyun.com/login/login.htm?oauth_callback=http%3A%2F%2Fdc.console.aliyun.com%2Fnext%2Findex%3Fspm%3D5176.2020520207.recommends.ddomain.606c4c12SpdlTJ#/domain/list/all-domain)

* [Get custom domain from Tecent](https://cloud.tencent.com/act/pro/domain_sales?fromSource=gwzcw.6927084.6927084.6927084&utm_medium=cpc&utm_id=gwzcw.6927084.6927084.6927084&bd_vid=11313871833741623980)

* [Manage your custom domain in Tecent](https://cloud.tencent.com/login?s_url=https%3A%2F%2Fconsole.cloud.tencent.com%2Flighthouse%2Fdomain%2Findex%3Frid%3D1)


Get SSL cert from public CA
```sh
sudo -i
```
```sh
yum update -y 
```
```sh
yum install -y curl
```
```sh
yum install -y socat
```
```sh
curl https://get.acme.sh | sh
```
```sh
~/.acme.sh/acme.sh --register-account -m <you mailbox>
```
```sh
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
```
```sh
~/.acme.sh/acme.sh --issue -d <FQDN of the Azure VM> --standalone
```

Install SSL cert
```sh
~/.acme.sh/acme.sh --installcert -d <FQDN of the Azure VM> --key-file /root/private.key --fullchain-file /root/cert.crt
```
![image](https://user-images.githubusercontent.com/96930989/212327231-b8766022-617a-482f-b3bc-95f81c659e88.png)


Install X-UI panel
```sh
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
```

Set up `username`, `password` and `listening port`

![image](https://user-images.githubusercontent.com/96930989/212327935-56c2162b-742c-4c4c-95ac-5a2146c5a14b.png)

Access to X-UI, offer the username and password set in the previous step
```
<ip of server>:8443
```
![image](https://user-images.githubusercontent.com/96930989/212440977-51d1124d-9bc4-470a-8799-2b86ecd82a7d.png)

Set the path of public key and private key, then click `Save` and reboot the `panel`
```
/root/cert.crt
```
```
/root/private.key
```
![image](https://user-images.githubusercontent.com/96930989/212328792-eb065394-170f-4968-b836-beb003feb096.png)

Then try to access X-ui using
```
<FQDN of the Azure VM>:8443
```
Configure like the sample below
![image](https://user-images.githubusercontent.com/96930989/212330149-419f8db5-eb3f-4346-8b26-1448003ea54e.png)

#### Run BBR or BBRplus service
##### 1. Run BBR Standard
Run command and press `4`
```sh
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```
![image](https://user-images.githubusercontent.com/96930989/212890569-fd3fabf8-0104-4c69-a2c8-b8cf1d3bcf14.png)

##### 2. Run BBRplus
Run command and press `2` for installation (it may take a while)
![image](https://user-images.githubusercontent.com/96930989/220104822-261d9440-98c8-4815-96d9-6f93cb4d628b.png)

The VPS server needs to be restarted, press `Y`
![image-20230819164323239](https://guguimage.aceultraman.com/i/2023/08/19/r6dasg-1.png)

Once the VPS server has restarted, run the command
```
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```

Press `7` to start BBRplus

![image](https://user-images.githubusercontent.com/96930989/220106727-9237e8ed-48d2-4789-8a7f-c9d87f4a1b82.png)

We also recommend to create scheduled tasks to reboot the server everyday.

### Create your VPN endpoints
#### 1. Add in shadowrocket on IOS device
Navigate to the url `<FQDN of the Azure VM>:8443`, click the `QR code` here, scan it using `shadowrocket`  
![image](https://user-images.githubusercontent.com/96930989/212442184-bbd4f329-f7d0-42c6-a286-f36f33ccca8d.png)

#### 2. Add Vmess endpoint in your openclash running on your openwrt
##### a. Create a vmess endpoint in your XUI portal (leave the port here default)
![image](https://user-images.githubusercontent.com/96930989/226164987-7b25227d-c06a-468c-9ba7-e431701a85e9.png)
##### b. Add new inbound rule for this default port on your VPS server
![image](https://user-images.githubusercontent.com/96930989/236832047-379f3f83-4bcc-4dbe-9cd2-3d3ba71df9f4.png) <br>
![image](https://user-images.githubusercontent.com/96930989/236832365-b37dc3a7-41ac-40f9-916b-adbdf4938e2e.png)

##### c. Once the Vmess endpoint is created, view it and copy the link
![image](https://user-images.githubusercontent.com/96930989/232296369-46f50470-cd8f-419f-9726-581428c4a6c8.png)
##### d. Navigate to openclash running on your openwrt, add new subscription
![image](https://user-images.githubusercontent.com/96930989/226165109-8109734b-a574-48b6-9a15-fab16fb9d2dd.png)
##### e. Once the vmess link is added and updated in openclash, you can switch to this new config file.
