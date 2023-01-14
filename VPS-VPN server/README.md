## Build your own VPS server running Linux
## Reference tutorial
https://www.youtube.com/watch?v=3ivwonJuqyI&t=0s

https://github.com/p4gefau1t/trojan-go/releases

### Deploy `trojan-go` on Ubuntu 2004 LTS
If the account used for RDP is not root account, then
```sh
sudo su root
```

```sh
mkdir trojan
```

```sh
cd trojan/
```

```sh
wget https://github.com/p4gefau1t/trojan-go/releases/download/v0.10.6/trojan-go-linux-amd64.zip
```

```sh
sudo apt install unzip
```

```sh
unzip trojan-go-linux-amd64.zip
```

```sh
./trojan-go
```

Creat a new file `config.json`

Configuration in json file
```
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 443,
    "remote_addr": "192.83.167.78",
    "remote_port": 80,
    "password": [
        "your_awesome_password"
    ],
    "ssl": {
        "cert": "server.crt",
        "key": "server.key"
    }
}
```

We will get these two files later after getting the cert and private key

![image](https://user-images.githubusercontent.com/96930989/212242830-7067c855-4c19-445a-ba0b-0dee310c708c.png)



### Get cert from public CA

Install acme
```sh
curl https://get.acme.sh | sh
```

Install socat
```sh
apt install socat
```
Add soft link
```sh
ln -s  /root/.acme.sh/acme.sh /usr/local/bin/acme.sh
```
Register account
```sh
acme.sh --register-account -m <your mailbox>
```

If the ufw is enabled, then add the rule UFW allow 80, or you can disable ufw
```sh
ufw allow 80
```

Get cert
```sh
acme.sh --set-default-ca --server letsencrypt
```

```sh
acme.sh  --issue -d <your domain name> --standalone -k ec-256
```

Install cert
```sh
acme.sh --installcert -d <your domain name> --ecc  --key-file   /root/trojan/server.key   --fullchain-file /root/trojan/server.crt 
```
Run trojan-go again
```sh
./trojan-go
```
![image](https://user-images.githubusercontent.com/96930989/212244288-017e0ab7-6b52-444d-8d4a-46a4e5568262.png)


### [Deploy Xray on Debian](https://www.youtube.com/watch?v=KGy4OMl02u8)
Check current system time
```sh
date
```
Modify system time
```sh
dpkg-reconfigure tzdata
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

Get ssl cert
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
Install cert
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
![image](https://user-images.githubusercontent.com/96930989/212332097-c30ae091-7309-4245-9b81-f79d344d1270.png)

Once the server has been restarted, run the command again, press `7` to start BBR
```sh
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```
![image](https://user-images.githubusercontent.com/96930989/212332772-36e9102b-d61c-465e-84fa-64847f4f6808.png)

