# Basics

Here, we will learn the basics of Java.

- Setting up the environment
- Write your first program
- Get to know the REPL
- Syntax and Keywords
- Examine the basic program structure

## Java

Java programming language was originally developed by Sun Microsystems which
was initiated by James Gosling and released in 1995 as core component of Sun
Microsystems' Java platform (Java 1.0 [J2SE]).  Java is guaranteed to be *Write
Once, Run Anywhere*.

## Environment

Explain Docker, git, Nano ...

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

## Syntax

- Case Sensitive
- Class Names 
- Method Names
- Program File Names
- Entry Point `public static void main(String args[])`

*Comments and blank lines*

Comments and blank lines are ignored.  There are several ways to write comments
depending on your needs.

- `// single line comment`
- `/* multi line comment */`
- `/** javadoc comment */`

*Identifiers*

Names used for classes, variables, and methods are called identifiers.

- begin with letter (a-z, A-Z), $ or _
- keywords cannot be used
- case sensitive

*Modifiers*

- Access Modifiers: default, public , protected, private
- Non-access Modifiers: final, abstract, strictfp

*Keywords*

You don't need to worry about these now, other than that they exist.

| abstract | assert       | boolean  | break      |
| byte     | case         | catch    | char       |
| class    | const        | continue | default    |
| do       | double       | else     | enum       |
| extends  | final        | finally  | float      |
| for      | goto         | if       | implements |
| import   | instanceof   | int      | interface  |
| long     | native       | new      | package    |
| private  | protected    | public   | return     |
| short    | static       | strictfp | super      |
| switch   | synchronized | this     | throw      |
| throws   | transient    | try      | void       |
| volatile | while        |






