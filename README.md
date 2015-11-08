# Shareabouts deployments for HeyDuwamish

Install [docker](http://docs.docker.com/engine/installation/) and [docker-compose](https://docs.docker.com/compose/install/). Note that docker-compose works best when installed within a virtualenv, using `pip install docker-compose`.

# To deploy the web application:
Set up your environment variable configuration file for the frontend via `mv frontend/.env.template frontend/.env`.

Deploy the containers via `cd frontend && ./deploy-compose.sh`.

Hope that helps!

# TODO: To deploy the api:

