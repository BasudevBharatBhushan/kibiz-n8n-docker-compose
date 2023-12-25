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
