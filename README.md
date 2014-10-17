# WordPress and Docker in MacOS

Docker image setup for WordPress. Based on [Tutum's WordPress No SQL image](https://github.com/tutumcloud/tutum-docker-wordpress-nosql).

## Setup

We'll setup docker in your Mac along with boot2docker. We'll also add guest volumes to docker and ssh capabilities. boot2docker is a lightweight linux VM. It's basically the linux machine that will run Docker in your mac. Docker runs on linux! boot2docker is a lightweight alternative to something like Vagrant, which is another way of having a Linux VM inside your mac. 

Guest volumes allow you to share files between your mac and your Linux VM. After you are sharing files with your Linux VM, these can also be shared with your Docker image. In this WordPress image we'll use guest volumes to share the `wp-content` directory with our docker image (hence leaving it in our mac, for faster editing). 

We'll also use something called `nsenter` to be able to SSH into our Docker image. Once you're inside the docker image you can `apt-get install` more packages or move stuff around.

Based on this: http://viget.com/extend/how-to-use-docker-on-os-x-the-missing-guide

See 'Setup.md'

## Running A Container

See 'Running A Container.md'.

## Assumptions

1. I'm assuming you're running a MySQL server in your Mac, not in your VM. This obviously need to change in order to be flexible. 
2. I'm assuming you're using guest volumes for your `wp-content` folder, which is where your theme, uploads and plugins will be installed.

## Questions

1. What would be the best way to standardize this in order to make the transition to production easier? 
2. How will our database setup look in a production environment?
3. The `wp-content` would behave very differently from development to production (no guest volumes), what's the best way to handle this?
4. Should we have 1 Dockerfile for all projects or 1 Dockerfile per project. The second one seems better.
5. What exactly does the `VOLUME` attribute do?

## Ideas 

1. Integrating npm, gulp, and compass into the container for front-end workflow
2. Setting up WP through the WP-CLI
3. Adding composer for plugin managment (plugins now trakced via git)
4. Install Varnish out of the box, for production.
5. Separate the `WordPress` part and the `Theme` into different volumes? (Dockerfile seems too long right now)

## Things I'm Probably Doing Wrong

1. These images take a REALLY long time to build. Should I not be using build? SHould I be caching the build in some way? Should I just learn the `docker add` command? 
2. Right now there's node, ruby, and apache+php. These should probably be separated into separate images. 
