# Install

```bash
# GOPATH, PATH are set up at /go
docker run -it --rm -v "$HOME/projects/dotfiles/playground/go":/go golang
```

**Setup paths**
```
export GOPATH="/Users/rtsunoda/projects/playground"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
```


**Install Go**
```
brew install go
```

**devtools**

```bash
go get golang.org/x/tools/cmd/godoc
go get github.com/golang/lint/golint
```

