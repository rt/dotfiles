
Run container

```bash
docker run -it --rm -v "$PWD":/usr/src/app -p 80:8080 --name skeleton-app-runtime skeleton-app
```

Get into a container

```bash
docker ps
docker exec -it <container id> /bin/bash
```
