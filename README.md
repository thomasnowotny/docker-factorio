# Factorio Game Server

### Introduction
This image allows you to run a factorio game server in a docker container. It provides several evironment variables to configure your server as well as volumes to store your savegames, mods and configs in a persistant manner. On startup the container checks for existing savegames, if none is present it will create a new map. It is also possible to run multiple maps with the same image by mounting the volumes for each container to different directories.

### News
#### 2014-04-10
It seems that the steam factorio client is still running on 0.12.29 and will not work with the latest version (0.12.30) of the server. In order to run the correct server version use thomasnowotny/factorio:0.12.29 when starting your container.

### Usage
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

### Configuration
The following environment variables are available:
* SCRIPT_AUTO_LOAD_LATEST_MODIFIED
  * Enables/disables auto load of latest modified savegame, this is useful to automatically load autosaves after unexpected server shutdowns
  * This option should only be enabled if no persistant storage is used or if every factorio container uses it's own persistant storage
  * Allowed values:"TRUE" or "FALSE"
  * Default value: "FALSE"
* FACTORIO_SAVE_NAME
  * Sets the savegame filename (without extension)
  * Default value: "save"
* FACTORIO_AUTOSAVE_INTERVAL
  * Sets the autosave interval in minutes
  * Default value: 10
* FACTORIO_AUTOSAVE_SLOTS
  * Sets the number of autosave slots
  * Default value: 3
* FACTORIO_LATENCY_MS
  * Sets the multiplayer latency in milliseconds
  * Default value: 100
* FACTORIO_ALLOW_COMMANDS
  * Enables/disables console commands
  * Allowed values: "TRUE" or "FALSE"
  * Default value: "TRUE"
* FACTORIO_AUTO_PAUSE
  * Enables/disables auto pause on empty server
  * Allowed values: "TRUE" or "FALSE"
  * Default value: "TRUE"
* FACTORIO_PEER_TO_PEER
  * Enables/disables peer to peer communication
  * Allowed values:"TRUE" or "FALSE"
  * Default value: "FALSE"
* FACTORIO_VERSION
  * Specifies the server binaries version to download
  * This is only used during docker image build process

### Volumes
The following volumes can be mounted:
* opt/factorio/config
* opt/factorio/saves
* opt/factorio/mods

### Versioning
I will try to keep this image up-to-date. If you require a previous version check the tags section or override the "FACTORIO_VERSION" environment varible inside the Dockerfile with your desired factorio server version and build the image locally.
