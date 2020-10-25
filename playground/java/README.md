# Java Notes

*Workflow*

Usually there will be something you want to look into (new java version,
specific functionality/library) and you need a place to try it out quickly and
leave it for reference.  The notes are for you, you don't have to be verbose.
Use gradle as your default build tool and write tests against what you are
testing.  Every module should be autonomous.

```
gradle init --type java-library
# or --type java-application
```

*Core*

- Java IO
- Regular Expressions
- Multithreading
- Loggin
- Annotations
- XML
- Collections
- Exception Handling
- Reflection
- JDBC
- java8

*Design Patterns*

- Creational
- Structural
- Behavioral

Java EE / Spring

Other 3rd Party


https://www.journaldev.com/1827/java-design-patterns-example-tutorial


## Environment


gradle and pom?


```
  docker run ...
```


## Directory Structure

Directory and package paths align.  There are `java` files, `test` files, and
`resources` all aligned in relative path structure.
Do a basic `tree` output here ...



*Adapter: class translates calls from one interfact to another.  Sometimes it
is used to name a class with do-nothing implementations of all methods of an interface.


## Lessons

- ✓ Basics: Getting started with Java
- ✓ Variables and Datatypes:  Get to know the different datatypes in Java, work with numbers, strings, date/time.
- Classes:  Learn the basics of classes, inheritance
- Operators and Conditionals:
- Arrays and Loop Control:
- Object Oriented: Inheritance, Overriding, Polymorphism, Abstration, Encapsulation, Interfaces
- Exceptions:
- Regular Expressions:
- Files and I/O:

## Design Patterns

## Topics not covered

https://docs.oracle.com/javase/tutorial/index.html

- JavaFX
- Swing
- Networking
- JMX
- JDNI
- JAXP
- RMI
- Security
- Sound
- 2D Graphics
- Sockets


## Random

*ThreadLocal:* Its purpose is to bind an object to a thread, which has two
distinct and useful consequences: The object is not shared between threads, so
it can be used without the need for synchronization; and it is available
throughout the life of the thread, meaning you don’t have to pass it all over
the place through method calls.  One common use is when an object is not thread-safe, but
you want to avoid synchronizing access to that object (like SimpleDateFormat) so 
you give each thread its own instance of the object.
