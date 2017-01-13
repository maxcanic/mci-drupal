# Local proxy

## Starting docker proxy container

```sh
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
  --name vps-proxy \
  --network=proxy_net \
  jwilder/nginx-proxy

# This is the same just less readable
docker run -d --restart=unless-stopped -p 80:80 -p 443:443 -v ${HOME}/Sites/proxy/certs:/etc/nginx/certs -v ${HOME}/Sites/proxy/htpasswd:/etc/nginx/htpasswd -v ${HOME}/Sites/proxy/conf.d:/etc/nginx/conf.d -v /var/run/docker.sock:/tmp/docker.sock:ro -e DEFAULT_HOST=localhost --name vps-proxy --network=proxy_net jwilder/nginx-proxy
```

