# Java 11

Java 9 and 10 are considered short term releases, and users should immediately transition to the next release when available.


## Java 9 new features

https://www.tutorialspoint.com/java9/java9_multirelease_jar.htm

- The Java Platform module system

It is hard to truly encapsulate code, and there is no notion of explicit
dependencies between different parts (JAR files) of a system. Every public
class can be accessed by any other public class on the classpath, leading to
inadvertent usage of classes that weren't meant to be public API

- Linking

Your application modules now state their dependencies on other application
modules and on the modules it uses from the JDK. Why not use that information
to create a minimal runtime environment, containing just those modules
necessary to run your application? That's made possible with the new jlink tool
in Java 9. Instead of shipping your app with a fully loaded JDK installation,
you can create a minimal runtime image optimized for your application.

- JShell: the interactive Java REPL

Testing a regular expression just became easier.  Let's use this.

Java 11 (LTS) 
