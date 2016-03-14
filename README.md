Factorio Game Server
===

Versioning
---
I will try to keep this image up-to-date. If you require a previous version check the tags section.
Introduction

---
This image allows you to run a factorio game server in a docker container. It provides several evironment variables to configure your server as well as volumes to store your savegames, mods and configs in a persistant manner. On startup the container checks for existing savegames, if none is present it will create a new map. It is also possible to run multiple maps with the same image by mounting the volumes to different directories.

Configuration
---
The following environment variables are available:
* FACTORIO_VERSION (specifies the server binaries version to download, default is "0.12.26")
* FACTORIO_SAVE_NAME (sets the naming of the savegame files, defaul is "mysave")
* FACTORIO_AUTOSAVE_INTERVAL (sets the autosave interval in minutes, default is 10)
* FACTORIO_AUTOSAVE_SLOTS (sets the number of autosave slots, default is 3)

The following volumes can be mounted:
* opt/factorio/config
* opt/factorio/saves
* opt/factorio/mods

Usage
---
To run factorio in a container without any persistant storage execute the following command:
~~~
docker run -d --name factorio \
  -p 34197:34197/udp \
  thomasnowotny/factorio:latest
~~~
To add persistant storage extend the previous command as follows (where PATH is a local directory of your choice):
~~~
docker run -d --name factorio \
  -p 34197:34197/udp \
  -v [PATH]:/opt/factorio/saves" \
  thomasnowotny/factorio:latest
~~~
To modify environment variables (e.g. increase savegame slots) execute:
~~~
docker run -d --name factorio \
  -p 34197:34197/udp \
  -v [PATH]:/opt/factorio/saves \
  -e FACTORIO_AUTOSAVE_SLOTS=10  \
  thomasnowotny/factorio:latest
~~~
