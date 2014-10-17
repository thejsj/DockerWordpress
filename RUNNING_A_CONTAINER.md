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

## Running A Container

```
docker -d -p 80:80 --name wp wp
```

3. Get the IP Address for your boot2docker vm:

If you have `dockerhost` setup in your `/etc/hosts`, you can skip this

```
boot2docker ip
```

4. Test it by going to `http://dockerhost`

5. If you're developing a site and want to edit files on your mac, you have to pass your theme directory to your container:

```
docker run -d -p 80:80 -v /Users/jorgesilvajetter/Desktop/wordpress-docker/cork-gulp:/app/wp/wp-content/themes/cork-gulp --name wp wp
```

You could also share the complete wp-content directory:

```
docker run -d -p 80:80 -v /Users/jorgesilvajetter/Desktop/wordpress-docker/wp-content:/app/wp/wp-content --name wp wp
```

Basically this shares our directory `/Users/jorgesilvajetter/Desktop/wordpress-docker/wp-content` with our docker container in `/app/wp/wp-content`. When we ssh into `/app/wp/wp-content` we find the contents of  `/Users/jorgesilvajetter/Desktop/wordpress-docker/wp-content`.