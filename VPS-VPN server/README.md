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


### [Deploy Xray on Ubuntu 2204LTS](https://www.youtube.com/watch?v=KGy4OMl02u8)

