# Podman Workspace

A script that runs a container keeping user/group IDs mounting current working dir with options for volumes, networks, and ports.

It will run into interactive mode with /bin/bash into the current working dir, providing a temporary isolated environment (as far as OCI Containers go).

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

## License

[MIT](./LICENSE)
