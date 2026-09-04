# Podman Workspace

A script that runs a container keeping user/group IDs mounting current working dir with options for volumes, networks, and ports.

It will run into interactive mode with /bin/bash into the current working dir, providing a temporary isolated environment (as far as OCI Containers go).

The current working directory is mounted at `/workspace` and the container's home dir is set to `/opt/podman-workspace`, the later is not mounted from
your host machine's home dir.

## Building and Installing

Container images are  stored in `images/$name`, and `make` can be used to build these.

Running `make/something` will trigger a build of `images/something` with podman, using the `Containerfile` and context of that directory.

A `config.local.mk` file can (sometimes need) to be created to load variables for a given rule or image, variables should be used as `$VARNAME_$IMG_NAME`, for example:

```
IMAGE_BUILD_OPTS_base:=--build-arg=USERNAME=$(shell id -un) --build-arg=UID=$(shell id -u) --build-arg=GID=$(shell id -g)
```

Sets additional podman build arguments for `image/base`.

`IMAGE_BUILD_OPTS` can also be used from the command line as a global variable for any rule, for example: `make image/something IMAGE_BUILD_OPTS=--no-cache`.

The rule `make install` will install `src/podman-workspace` into `BIN_DIR` which defaults to `$HOME/.local/bin`.

All images are built as `localhost/podman-workspace:$name`, with `localhost/podman-workspace:base` being used as the parent image.

## Usage

```
podman-workspace [OPTIONS]

Options:
  --image=<image>             [Optional] Container image to use (default: localhost/podman-workspace:base).
  --network=<network>         [Optional] Sets a network to use (default: bridge).
  --env-var=<name>=<value>    [Optional] set a environment variable 
                              Can be used multiple times
  --volume=<volume>           [Optional] Additional volume to mount (e.g, /host/path:/container/path). 
                              Can be used multiple times.
  --port=<port>               [Optional] Port to publish (e.g., 8080:80). 
                              Can be used multiple times.
  --help                      Display this help message and exit.

Examples:
  podman-workspace
  podman-workspace --image=localhost/podman-workspace:base --network=host --volume=/app/data:/data:ro,z --volume=/app/logs:/logs --port=3000:3000/udp --port=9229:9229
```

Once invoked, the CLI will shell into a Linux container which is configured based on the passed arguments.

The working directory is set to /workspace, which is mounted from the host's `$PWD`.

## License

[MIT](./LICENSE)

