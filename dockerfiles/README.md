# Dockerfiles

Builds for tools

From child directory

```
docker build -t name .
docker run -it name
```

Note: An idea might be to have a tmux session that you connect to

```
docker run -it -d -p 8654:22 <image name>
```

```
ssh user@<hostname> -p 8654 -t "tmux a -t mysesh"
```
