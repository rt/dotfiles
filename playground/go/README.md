# Go
 
Normally you would have a repo per module (ie. hello/) but here we have a bunch of modules to play with.


### Getting Started

**Setup paths**
```
export GOPATH="/Users/rtsunoda/projects/playground"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
```


**Install Go**
```
brew install go
# devtools
go get golang.org/x/tools/cmd/godoc
go get github.com/golang/lint/golint
```

**Create a module**

Create a `go.mod` file.
```
mkdir hello
cd hello/
go mod init github.com/rt/hello
```

Create a binary to bin/
The install directory is controlled by the GOPATH and GOBIN environment variables.

From the working directory
```
go install github.com/rt/hello
```

Or, relative.
```
go install
```

**Run the binary**
```
hello
```




**Running without packaging**

```
cd hello/
go run hello.go
```


**Compiling a package**

```
cd hello/morestrings/
go build
```


**Clean module cache**

```
go clean -modcache
```


### Testing

Conventions

| File name          | Test name | Trigger Error     |
| <filename>_test.go | TestXXX   | t.Error or t.Fail |

From where the tests are
```
go test
```
