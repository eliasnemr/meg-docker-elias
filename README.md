# MEG Docker

Docker image creation for [MEG](https://github.com/minima-global/emh).

## Install and run MEG

1. Run `docker compose up` at the root of this repo.
2. Open a browser and go to `127.0.0.1:9004` to open your MiniDAPP Hub.
3. Install the `emh.minidapp` which you will find in the `./dapps` folder of this repo.

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
