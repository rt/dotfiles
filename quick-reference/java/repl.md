# repl

## jshell (REPL)

- Methods can be added by typing their signature and body
- Variables can be defined with the normal Java declaration syntax
- Any valid Java expression is accepted and the result of the evaluation will be shown. If no explicit receiver of the result is provided, “scratch” variables will be created


*Commands*

- /import
- /var
- /methods
- /list or /history
- /save repl.java  > /open repl.java
- /exit

```bash
# starts in jshell by default
docker run -it --rm openjdk:11
docker run -it --rm -v "$PWD":/usr/src/app openjdk:10
```




## App Environment

```
docker build -t basics .

```

```
docker run -it --rm -v "$PWD":/usr/src/app --name basics-running basics
```

```
java -version
```

Compile and see that it creates the `HelloWorld.class` file.

```
javac HelloWorld.java
```

Run the program

```
java HelloWorld
```

##  Demo
```
docker build -t basics .
docker run -it --rm -v "$PWD":/usr/src/app --name basics-running basics
```

```
javac [Name].java && java [Name]
```
