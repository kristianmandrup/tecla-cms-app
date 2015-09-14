Docker Deployment
-----------------

Prerequisites
-------------

You need [docker](https://docs.docker.com/installation/) or [boot2docker](http://boot2docker.io/) installed!

### Mac OSX

[Install Docker on Mac OSX](http://blog.javabien.net/2014/03/03/setup-docker-on-osx-the-no-brainer-way/)

Or perhaps try `npm install -g docmac && docmac`

Note: You need to be sure you link docker `/usr/local/bin/docker`

Or try the [Docker Toolbox](https://www.docker.com/toolbox) to quickly setup a suitable Docker environment!

### Ubuntu

[Ubuntu docker install](https://docs.docker.com/installation/ubuntulinux/)

### Windows

[Windows install](https://docs.docker.com/installation/windows/)

### Docker + docker-compose

Just run `docker-compose up` in order to build the required images and start the containers in the proper order. This command *will* take several minutes to complete. Go grab a coffee.

After it's done, run `docker-compose ps` to make sure all containers are up and running. Then, visit http://localhost to open the application.

At this point, feel free to change some code and refresh the browser to see the changes right away, without the need to reload the container yourself.

### Docker tutorials

A nice walk through of hwo to do a complete setup (Php)

-	[Part I: Docker](http://piotrpasich.com/continuous-deployment-environment-with-docker-aws-eb-and-codeship/)
-	[Part II: AWS Elastic Beanstalk](http://piotrpasich.com/automated-deployment-with-aws-elastic-beanstalk-eb-part-ii/)
-	[Part III: Codeship](http://piotrpasich.com/putting-all-pieces-together-and-shipping-with-codeship-continuous-deployment-part-iii/)

### Docker deploy with private repos

Note: Work In Progress (WIP)

Use the `Dockerfile.private`.

`docker build -f Dockerfile.private -t cms .`

-	[pulling-git-ssh](http://blog.cloud66.com/pulling-git-into-a-docker-image-without-leaving-ssh-keys-behind/)
-	[private git repos docker](http://simonrobson.net/2014/10/14/private-git-repos-on-docker-images.html)

See also:

-	[docker git](http://slash-dev-blog.me/docker-git.html)
-	[simpliy: ssh config file](http://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/)

To work with your ssh config, try the [ssh-config](https://github.com/dbrady/ssh-config) tool (ruby). See [bin](https://github.com/dbrady/ssh-config/blob/master/bin/ssh-config)

```sh
# file: ssh/config

#kmandrup account
Host github.com-kristianmandrup
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_km
```

-	Create a key, such as with `ssh-keygen` on Mac OSX or use an existing SSH key.
-	Copy a public key with a matching Deploy key into `/ssh`

`cp -r /Users/kristianmandrup/.ssh/ ssh`

To run container with SSH agent forwarding

Maybe use: [ssh agent forwarding script](https://gist.github.com/rcoup/53e8dee9f5ea27a51855)

```sh
boot2docker ssh -A
docker run -i -t -v $(readlink -f $SSH_AUTH_SOCK):/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent ubuntu /bin/bash
```

### Docker deployment to the cloud

Here's how to do it manually so you can automate the process however you want.

First, clone this project in your server and run `docker build -t cms .` in order to build the base image.

After that, go to `config/docker/cms_deploy` and change whatever config you want. Then, run `docker build -t cms_<env> .` to build the image tailored for the environment `env` (.i.e. `production`).

Do the same procedure in `config/docker/nginx` and build the image with`docker build -t cms_nginx .`.

Finally, it's time to start the containers:

```bash

$ sudo docker run --name cms_mongodb -d mongo
$ sudo docker run --name cms_<env>_1 -d --link cms_mongodb:mongodb cms_prod
$ sudo docker run --name cms_nginx_1 -d --link cms_<env>_1:app --volumes-from cms_<env>_1 -p 80:80 cms_nginx
```

Run `docker ps` to make sure all containers are up and running. Then, visithttp://your-server-ip to open the application.

### Docker Machine deployment to the cloud

TODO
