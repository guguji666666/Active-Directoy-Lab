## Deploy X-UI on Azure VM running Debian 10/11
### Video tutorial
https://www.youtube.com/watch?v=KGy4OMl02u8
### Before we start
1. Make sure you have a custom domain
2. Add DNS `A` record in your DNS provider, point `FQDN` to your Azure VM's IP
```
For example,
You bought Domain "abc.com" from DNS provider.
Then you create FQDN "test.abc.com" for your Azure VM.
DNS A record > points "test.abc.com" to the IP of Azure VM.
```

Switch to root account
```sh
sudo su root
```
Switch directory
```
cd ~
```
Check current system time
```sh
date
```
Modify system time
```sh
dpkg-reconfigure tzdata
```
Install ufw
```sh
apt install ufw
```
Open the ports
```sh
ufw allow 80
```
```sh
ufw allow 443
```
```sh
ufw allow 8443
```

Get ssl cert fron public CA
```sh
apt update -y 
```
```sh
apt install -y curl
```
```sh
apt install -y socat
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
~/.acme.sh/acme.sh --issue -d <your FQDN of server> --standalone
```
Install ssl cert
```sh
~/.acme.sh/acme.sh --installcert -d <your FQDN of server> --key-file /root/private.key --fullchain-file /root/cert.crt
```
![image](https://user-images.githubusercontent.com/96930989/212327231-b8766022-617a-482f-b3bc-95f81c659e88.png)

Install X-UI panel
```sh
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
```
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
<FQDN of server>:8443
```
Configure like the sample below
![image](https://user-images.githubusercontent.com/96930989/212330149-419f8db5-eb3f-4346-8b26-1448003ea54e.png)

Install BBR to speed up, press `2` to install, server will be required to reboot after installation
```sh
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```
Press `No` and Enter
![image](https://user-images.githubusercontent.com/96930989/212332097-c30ae091-7309-4245-9b81-f79d344d1270.png)

Once the server has been restarted, run the command again, press `7` to start BBR
```sh
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```
![image](https://user-images.githubusercontent.com/96930989/212332772-36e9102b-d61c-465e-84fa-64847f4f6808.png)

