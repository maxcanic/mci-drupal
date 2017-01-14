# Local proxy

There are many solutions for proxying containers to names on localhost, however solution by [Jason Wilder](http://jasonwilder.com) [nginx-proxy](https://github.com/jwilder/nginx-proxy) was relatively easy to implement and works smoothly.

## Starting docker proxy container

Creating the network and running one of the commands below ensures that even after computer (service) restart, it will restart proxy as well.

The best source of detailed information is in project [README.md](https://github.com/jwilder/nginx-proxy) file.

```sh
# First we need proxy net
docker network create proxy_net

# This is for SERVER
docker run \
  -d \
  --restart=unless-stopped \
  -p 80:80 \
  -p 443:443 \
  -v /data/proxy/certs:/etc/nginx/certs \
  -v /data/proxy/htpasswd:/etc/nginx/htpasswd \
  -v /data/proxy/conf.d:/etc/nginx/conf.d \
  -v /var/run/docker.sock:/tmp/docker.sock:ro \
  -e DEFAULT_HOST=my.mek.rs \
  --name d4d-proxy \
  --network=proxy_net \
  jwilder/nginx-proxy

# This is for LOCAL
docker run -d --restart=unless-stopped -p 80:80 -p 443:443 -v ${HOME}/Sites/proxy/certs:/etc/nginx/certs -v ${HOME}/Sites/proxy/htpasswd:/etc/nginx/htpasswd -v ${HOME}/Sites/proxy/conf.d:/etc/nginx/conf.d -v /var/run/docker.sock:/tmp/docker.sock:ro -e DEFAULT_HOST=localhost --name d4d-proxy --network=proxy_net jwilder/nginx-proxy
```

We are mounting three local directories to enable using **htpasswd** basic authentication and providing certificates in **certs**. Additional configurations are added in files in `conf.d` directory according to [proxy wide configurations](https://github.com/jwilder/nginx-proxy#proxy-wide).

We choose to use `proxy_net` as a network name where all containers will be joined and **proxy** will configure and expose them according to name given in environment variable of the container.

Add appropriately these lines to your `docker-compose.yml` file to have your container services available on domains

```
    # ...
    #   Add this to container
    #   and specify port if it is not standard 80
    #   it will be accessible on domain name without the need for port
    environment:
      VIRTUAL_HOST: my-project.dev.devbox21.com
      VIRTUAL_PORT: 8025
    networks:
      - proxy_net
      - default

# At the end, add network as external
networks:
  proxy_net:
    external: true

```
