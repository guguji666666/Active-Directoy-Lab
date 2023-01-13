## Build your own VPS server running Linux
## Reference tutorial
https://www.youtube.com/watch?v=3ivwonJuqyI&t=0s

https://github.com/p4gefau1t/trojan-go/releases

### Deployment steps
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
![image](https://user-images.githubusercontent.com/96930989/212097706-0adfd1db-55e8-48e6-8296-1dbcdfc821e4.png)

![image](https://user-images.githubusercontent.com/96930989/212097801-aa18cdb7-cdf7-4df1-94fd-d4253ed89c43.png)

![image](https://user-images.githubusercontent.com/96930989/212097960-e65c7759-7547-41ef-91b6-73359387ba7f.png)

```sh
./trojan-go
```
![image](https://user-images.githubusercontent.com/96930989/212098669-5eb6fa54-bd74-4d63-9a15-12a0050e2a7c.png)

Creat a new file `config.json`
![image](https://user-images.githubusercontent.com/96930989/212099535-b0195e7a-7c2d-4f1a-ac5d-bda3ed5be855.png)

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

We will get these two files later

![image](https://user-images.githubusercontent.com/96930989/212102933-8eb8d90f-4a4d-4cc1-813d-7edc35308e55.png)


### Get cert from public CA

Install acme
```sh
curl https://get.acme.sh | sh
```
![image](https://user-images.githubusercontent.com/96930989/212106028-657a0f1e-939c-4bf4-a2e0-f29685196be7.png)

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
![image](https://user-images.githubusercontent.com/96930989/212207475-54f0ac78-f7d5-4a73-b9fe-3407a3bfeeaa.png)

UFW allow 80
```sh
ufw allow 80
```
![image](https://user-images.githubusercontent.com/96930989/212207660-64459f31-44b6-4e66-94cd-1458d859c757.png)

Get cert
```sh
acme.sh  --issue -d <your domain name> --standalone -k ec-256
```
Install cert
```sh
acme.sh --installcert -d <your domain name> --ecc  --key-file   /root/trojan/server.key   --fullchain-file /root/trojan/server.crt 
```
