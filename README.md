# LetsDeploy!

## What is this?
**LetsDeploy** is a configuration script to deploy your app in a production environment using [Letsencrypt](https://letsencrypt.org/) for SSL and an [Nginx webserver](http://nginx.org/). **LetsDeploy** runs on Docker and Docker-Compose.

To use **LetsDeploy**, we are assuming that you have containerized your application.

Feel free to fork this project, dial in your config (explained below), and get your production environment up asap!

**NOTE:** **LetsDeploy** is designed to get your demo(s) into production with minimal cost. It deploys your apps to a single-server environment, so it is not yet designed for scalability.

## Simple deployment: LetsDeploy this as-is:

### Install Docker dependencies:
This should get you started: https://docs.docker.com/engine/installation/

Or if you're feel courageous, you can try this:

```
wget -qO- https://get.docker.com/ | sh
```

**then install docker-compose**

(if you did the Mac install, then you can skip the docker-compose step because it's already included.)

using pip or whatever works for you:

```
sudo apt-get install python-pip
# or try this:
sudo easy_install pip
```

then:

```
pip install docker-compose
```

### Dial in your config:
Create your `.env` file from the template, ie `cp .env.template .env`. Follow the instructions in that file to get your app running that way you want. Passwords, customized settings, etc, should all be in your `.env` file.

### Let.Us.Deploy!
When ready, just run `./letsdeploy.sh`! Do you want to re-deploy? Have you made any changes, and you want to update your site? Just run `./letsdeploy.sh` again!

The letsdeploy command is idempotent, and the docker-compose wrapper script will tear down and re-orchestrate your containers. This makes it easy to manage the state of your deployment.

## Customizing the deployment:
We are using Docker-Compose version 2 (latest version), so just edit the `example.yml` file as needed, and connect it with your `.env` files by including variable names using standard shell syntax (ie `$MY_VARIABLE` or `${MY_VARIABLE}`)

### How do I test this locally?
The automated ssl cert generation/renewal makes this a bit complicated, but we are working to simplify this. For now, to test it locally, just comment out the `letsencrypt`, `nginx`, and `letsencrypt-nginx-cron` containers in `nginx.yml`, and copy this to the end of `example.yml`:

```yml
  nginx:
    image: nginx
    volumes:
      - ./nginx-local.conf:/etc/nginx/nginx.conf
    links:
      - app
    ports:
      - 80:80
    restart: always
```
