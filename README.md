# ELK-Cleaner

> **This is NOT suitable for production use**
> 
> It's a dirty (yet educational) hack to investigate Dockerfiles, Bash scripting, and the ElasticSearch HTTP API

## Summary
This originated to assist running an ELK stack in a disk-space-constrained environment, where I did not have access to admin settings or any other log-cleanup tools.

It makes the assumption that your indexes are named `logstash-yyyy.MM.dd` (which they are if you use the default settings with [Serilog.ElasticSearch](https://github.com/serilog/serilog-sinks-elasticsearch)).

Highly useful for running an ELK stack locally for developing against. For instructions on that, [see this very useful repo](https://github.com/deviantony/docker-elk).

## Building it
```docker build -t elk-cleaner .```

## Some notes
* The `Alpine` base Linux image is very minimal, down to not including `bash`. In this (admittedly very limited) case, `sh` is a suitable alternative.
  * If not, running `apk add bash` as part of the Dockerfile will include it within the created image
* Shell scripts created on Windows must use Unix line-endings - if Windows line endings are used by mistake, the error message will not be helpful
* Networking within a container can be finicky, some things which are implicit when run directly on the host no longer hold true. E.g.
  * `localhost` refers to the loopback within the container, not the host. Using the machine name explicitly
  * You may need to fully-qualify names (`hostname.domain`). These may resolve fine on the host using only the hostname, but may not within the container.