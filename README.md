# Deploy n8n with Postgresql on EC2

## Pre-requisits

### Curl

```
sudo apt update
sudo apt install curl
```

### Vim

```
sudo apt install vim
vim --version
```

### Ngnix (For Reverse Proxy)

```
sudo apt-get install nginx
```

Starts n8n with PostgreSQL as database.

## Steps

### Step 1: Docker Installation

- [Official Link](https://docs.docker.com/engine/install/ubuntu/)

```
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

#### Add Docker's official GPG key:

```
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

#### Add the repository to Apt sources:

```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
```

#### Install Latest Docker Version

```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

docker --version


```

#### Install Docker Compose

```
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version

```

### Step 2: Clone the Docker-Compose File for n8n with postgresql database

- [Official Repo](https://github.com/n8n-io/n8n/tree/master/docker/compose/withPostgres)

#### Note: This docker compose repo is customized for Kibiz (Contains sensitive info in the env variable)

```
git clone https://github.com/BasudevBharatBhushan/kibiz-n8n-docker-compose
```

#### Check Docker-Compose Configuration (If env variables are set properly)

```
eval $(egrep -v '^#' .env | xargs) docker-compose config
```

### Step 3: Start n8n process

#### Start Docker Compose

```
docker-compose up -d
```

#### Terminate Docker Compose

```
docker-compose down
```

---

## To check logs of application

```
docker-compose logs -f
```

### Step 4: Ngnix Setup

n8n Ngnix Setup - Link - https://community.n8n.io/t/connection-lost-warning/29966/6

#### Go to the Default Configuration of Nginx using vim

```
sudo vim /etc/ngnix/site-available/default
```

```
 location / {
                proxy_pass http://127.0.0.1:5678;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'Upgrade';
                proxy_set_header Host $host;
                chunked_transfer_encoding off;
                proxy_buffering off;
                proxy_cache off;
                # First attempt to serve request as file, then
                # as directory, then fall b
                #ack to displaying a 404.
                #try_files $uri $uri/ =404;
        }
```

#### Test Nginx syntax

```
sudo ngnix -t
```

### Step 5: SSL Setup using Certbot

[Offical Link](https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal)

#### Install Snapd

```
sudo apt update
sudo apt install snapd
```

#### Install Certbot

```
sudo snap install --classic certbot

sudo ln -s /snap/bin/certbot /usr/bin/certbot
```

#### Generate certificate

```
sudo certbot --nginx -d kiflow.kibizsystems.com
```

#### Test Certbot

```
sudo certbot renew --dry-run
```

---

## Commands to interact with the postgresql

### Access the Postgresql terminal

```
sudo docker exec -it <containerID> bash
```

### List all the databases

```
sudo -u postgres psql -c '\l'
```

### Go to the N8N database terminal

```
psql -U postgres -d n8n

```

### List all the tables

```
\dt
```

### To query a table

```
SELECT * FROM "user";
```

### To exit of the terminal

```
\q
```

### To exit of psql shell

```
exit
```
