# Factorio Game Server

#### Introduction
This image allows you to run a factorio game server in a docker container. It provides several evironment variables to configure your server as well as volumes to store your savegames, mods and configs in a persistant manner. On startup the container checks for existing savegames, if none is present it will create a new map. It is also possible to run multiple maps with the same image by mounting the volumes for each container to different directories.

#### Configuration
The following environment variables are available:
* FACTORIO_SAVE_NAME (sets the naming of the savegame files, defaul is "save")
* FACTORIO_AUTOSAVE_INTERVAL (sets the autosave interval in minutes, default is 10)
* FACTORIO_AUTOSAVE_SLOTS (sets the number of autosave slots, default is 3)
* FACTORIO_LATENCY_MS (sets the multiplayer latency in milliseconds, default is 100)
* FACTORIO_ALLOW_COMMANDS (enable/disable console commands, allowed values are "TRUE" or "FALSE", default is "TRUE")
* FACTORIO_AUTO_PAUSE (enable/disable auto pause on empty server, allowed values are "TRUE" or "FALSE", default is "TRUE")
* FACTORIO_PEER_TO_PEER (enable/disable peer to peer communication, allowed values are "TRUE" or "FALSE", default is "FALSE")
* FACTORIO_VERSION (specifies the server binaries version to download, this is only used on building the docker image)

The following volumes can be mounted:
* opt/factorio/config
* opt/factorio/saves
* opt/factorio/mods

#### Usage
To run factorio in a container without any persistant storage execute the following command:
~~~sh
docker run -d --name factorio \
  --restart="always" \
  -p 34197:34197/udp \
  thomasnowotny/factorio:latest
~~~
To add persistant storage extend the previous command as follows (where PATH is a local directory of your choice):
~~~sh
docker run -d --name factorio \
  --restart="always" \
  -p 34197:34197/udp \
  -v [PATH]:/opt/factorio/saves \
  thomasnowotny/factorio:latest
~~~
To modify environment variables (e.g. increase savegame slots) adapt the previous command as follows:
~~~sh
docker run -d --name factorio \
  --restart="always" \
  -p 34197:34197/udp \
  -v [PATH]:/opt/factorio/saves \
  -e FACTORIO_AUTOSAVE_SLOTS=10 \
  thomasnowotny/factorio:latest
~~~
At this point the factorio server can be started/stopped by executing
~~~sh
docker stop factorio
~~~
or
~~~sh
docker start factorio
~~~

#### Versioning
I will try to keep this image up-to-date. If you require a previous version check the tags section or override the "FACTORIO_VERSION" environment varible inside the Dockerfile with your desired factorio server version and build the image locally.
