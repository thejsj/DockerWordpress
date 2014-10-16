# WordPress and Docker in MacOS

Docker image setup for WordPress. Based on [Tutum's WordPress No SQL image](https://github.com/tutumcloud/tutum-docker-wordpress-nosql).

## Setup

We'll setup docker in your Mac along with boot2docker. We'll also add guest volumes to docker and ssh capabilities. boot2docker is a lightweight linux VM. It's basically the linux machine that will run Docker in your mac. Docker runs on linux! boot2docker is a lightweight alternative to something like Vagrant, which is another way of having a Linux VM inside your mac. 

Guest volumes allow you to share files between your mac and your Linux VM. After you are sharing files with your Linux VM, these can also be shared with your Docker image. In this WordPress image we'll use guest volumes to share the `wp-content` directory with our docker image (hence leaving it in our mac, for faster editing). 

We'll also use something called `nsenter` to be able to SSH into our Docker image. Once you're inside the docker image you can `apt-get install` more packages or move stuff around.

Based on this: http://viget.com/extend/how-to-use-docker-on-os-x-the-missing-guide

### Part 1: Setting Up Docker and boot2docker

1. Install docker and boot2docker
```
brew update
brew install docker
brew install boot2docker
```

2. Add Guest Additions, Initialize and start boot2docker

Add Guest Additions to boot2docker. This allows boot2docker to access your directory in your mac. Remember, Docker runs in a *Linux* virtual machine inside your mac (that's essentially what boot2docker is!), so it does not have access to your file system by default. 

```
curl http://static.dockerfiles.io/boot2docker-v1.2.0-virtualbox-guest-additions-v4.3.14.iso > ~/.boot2docker/boot2docker.iso
VBoxManage sharedfolder add boot2docker-vm -name home -hostpath /Users
```

Then start up boot2docker.

```
boot2docker init
boot2docker up
```

Your `up`, will output something like this:

```
To connect the Docker client to the Docker daemon, please set:
    export DOCKER_HOST=tcp://SOME_IP_ADRESS:SOME_PORT_NUMBER
```

Go ahead and do that:
```
export DOCKER_HOST=tcp://SOME_IP_ADRESS:SOME_PORT_NUMBER
```

3. See if it all worked:

```
> docker info
Containers: 0
Images: 0
Storage Driver: aufs
 Root Dir: /mnt/sda1/var/lib/docker/aufs
 Dirs: 0
Execution Driver: native-0.2
Kernel Version: 3.15.3-tinycore64
Debug mode (server): true
Debug mode (client): false
Fds: 10
Goroutines: 10
EventsListeners: 0
Init Path: /usr/local/bin/docker
Sockets: [unix:///var/run/docker.sock tcp://0.0.0.0:2375]
```

4. Add this to your bash profile and re-run your `~/.bash_profile`

```
docker-ip() {
  boot2docker ip 2> /dev/null
}
```

5. Add Docker's VM's IP address to your hosts file 

This will make it possible to go to http://dockerhost:PORT_NUMBER

```
echo $(docker-ip) dockerhost | sudo tee -a /etc/hosts
```

The IP address part can become a little tricky, because IP addresses can change over time if you are using multiple VMs (which we do a lot of at CO+LAB). If something is not working, this is a good place to start debugging.

6. Install `nsenter` to SSH into your Docker image

First, ssh into your boot2docker VM

```
boot2docker ssh
```

Now, inside your boot2docker VM, install `nsenter`

```
docker run --rm -v /var/lib/boot2docker:/target jpetazzo/nsenter
```

Once that's done, add `/var/lib/boot2docker` to the PATH: 

```
echo 'export PATH=/var/lib/boot2docker:$PATH' >> ~/.profile
source ~/.profile
```

After that, go back to your Mac (`exit`) and add this script somewhere:

```
#!/bin/bash
set -e
 
# Check for nsenter. If not found, install it
boot2docker ssh '[ -f /var/lib/boot2docker/nsenter ] || docker run --rm -v /var/lib/boot2docker/:/target jpetazzo/nsenter'
 
# Use bash if no command is specified
args=$@
if [[ $# = 1 ]]; then
  args+=(/bin/bash)
fi
 
boot2docker ssh -t sudo /var/lib/boot2docker/docker-enter "${args[@]}"
```

You can add it to `~/docker-enter.sh`, then `chmod +x` it, and then try to ssh into it. 

```
docker run -d -P --name web nginx # Create an instance of Docker
~/docker-enter.sh web
```

This part is kind of tricky, so if that doesn't work go refer to the [Viget article](http://viget.com/extend/how-to-use-docker-on-os-x-the-missing-guide).

#### Testing That It Works (Optional)

To quickly test if this works, you can setup a quick nginx container that will server a simple static html page. 

1. Start a container running nginx

```
docker run -d -P --name web nginx
```

2. Check that it's running

```
> docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                   NAMES
0092c03e1eba        nginx:latest        nginx               44 seconds ago      Up 41 seconds       0.0.0.0:49153->80/tcp   web
```

3. Open it in your browser with  http://dockerhost:PORT_NUMBER

Great, it works! Remmeber, that we setup `dockerhost` previously and added it to our `/etc/hosts`. If you didn't do that then run this command to get the IP address for the container: 

```
boot2docker ip
```

To get the port number, run this:

```
docker port web 80
```

4. Then kill it
```
docker stop web
docker rm web
```

## Running A Container

1. Build the container

```
docker build -t IMAGE_TAG LOCATION_OF_IMAGE
```

Something like this

```
cd ~/ && git@github.com:thejsj/DockerWordpress.git
docker build -t wp ~/DockerWordpress
```

2. Run the container

Once the container is built, run it.

```
docker -d -p 80:80 --name wp wp
```

3. Get the IP Address for your boot2docker vm:

If you have `dockerhost` setup in your `/etc/hosts`, you can skip this

```
boot2docker ip
```

4. Test it by going to `http://dockerhost`