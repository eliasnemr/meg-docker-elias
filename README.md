# MEG Docker

Docker image creation for [MEG](https://github.com/minima-global/emh).

## Install

Below decribes how to build the docker image for MEG and then run the container

### Build the Image

To create the docker image, run:

`sudo docker build -t glowkeeper/meg:1.0.0 .`

That installs Ubuntu with _MySQL_, the _JRE_ and _curl_.

Next, you will need to configure MySQL (because MySQL is mounted on [Docker Volumes](https://docs.docker.com/storage/volumes/) you should only need to do this once). To do so, fire up a command prompt in the image created above:

`sudo docker run -v mysql:/var/lib/mysql -u 0 --entrypoint /bin/bash -it glowkeeper/meg:1.0.0`

Start MySQL via `mysqld &`, then set some secure defaults:

`mysql_secure_installation`

Now fire up a MySQL prompt:

`mysql -u root -p`

...providing the root password you created when running `mysql_secure_installation`.

Now create the _minima_ database and user, and assign appropriate privileges.

`CREATE USER 'minima'@'localhost' IDENTIFIED BY 'you_secure_password';`
`GRANT ALL PRIVILEGES ON *.* TO 'minima'@'localhost' WITH GRANT OPTION;`
`FLUSH PRIVILEGES;`

## Run

Now you can run the container:

`sudo docker run -v mysql:/var/lib/mysql -v dapps:/home/minima/.minima/webroot/minidapps -p 9001:9001 -p 9002:9002 -p 9003:9003 -p 9004:9004 glowkeeper/meg:1.0.0`

## Useful Commands

Fire up a root shell in the running container:

`sudo docker exec -u 0 -it containerId /bin/bash`

Stop a container:

`sudo docker stop containerId`

Get the containerId via:

`sudo docker container ls`

Remove an image:

`sudo docker rmi imageId -f`

Get the imageId via:

`sudo docker images`
