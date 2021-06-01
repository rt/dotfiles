**Create a module**

Create a `go.mod` file.
```
mkdir hello
cd hello/
go mod init github.com/rt/hello
```

**Create a binary to bin/**

The install directory is controlled by the GOPATH and GOBIN environment variables.
From the working directory
```
go install github.com/rt/hello
```

Or, relative.
```
go install
```

*Run the binary*
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

