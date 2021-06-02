# repl

```bash
git clone https://github.com/motemen/gore.git
cd gore
docker build -t gore .
docker run -it --rm gore
```

```
:import <package path>  Import package
:type <expr>            Print the type of expression
:print                  Show current source
:write [<filename>]     Write out current source to file
:clear                  Clear the codes
:doc <expr or pkg>      Show document
:help                   List commands
:quit                   Quit the session
```

