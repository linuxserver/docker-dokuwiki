[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://www.dokuwiki.org/dokuwiki
[hub]: https://hub.docker.com/r/linuxserver/dokuwiki/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuserver/dokuwiki
[![](https://images.microbadger.com/badges/version/linuxserver/dokuwiki.svg)](https://microbadger.com/images/linuxserver/dokuwiki "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/dokuwiki.svg)](http://microbadger.com/images/linuxserver/dokuwiki "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/dokuwiki.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/dokuwiki.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-dokuwiki)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-dokuwiki/)

[DokuWiki][appurl] is a simple to use and highly versatile Open Source wiki software that doesn't require a database. It is loved by users for its clean and readable syntax. The ease of maintenance, backup and integration makes it an administrator's favorite. Built in access controls and authentication connectors make DokuWiki especially useful in the enterprise context and the large number of plugins contributed by its vibrant community allow for a broad range of use cases beyond a traditional wiki.

[![dokuwiki](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/dokuwiki-icon.png)][appurl]

## Usage

```
docker create \
  --name=dokuwiki \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 80:80 \
  linuserver/dokuwiki
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`



* `-p 80` - the port(s)
* `-v /config` - where dokuwiki should store its files.
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it dokuwiki /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Find the webui at `<your-ip>:80`, for more info see [Dokuwiki][appurl]

## Info

* Shell access whilst the container is running: `docker exec -it dokuwiki /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f dokuwiki`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' dokuwiki`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuserver/dokuwiki`

## Versions

+ **dd.mm.yy:** Initial Release.
