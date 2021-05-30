# Exceptions

> An exception is an event, which occurs during the execution of a program,
> that disrupts the normal flow of the program's instructions.

When an error occurs within a method, the method creates an object and hands it
off to the runtime system. The object, called an exception object, contains
information about the error, including its type and the state of the program
when the error occurred. Creating an exception object and handing it to the
runtime system is called throwing an exception.


The runtime system searches the call stack for a method that contains a block
of code that can handle the exception. This block of code is called an
exception handler. The search begins with the method in which the error
occurred and proceeds through the call stack in the reverse order in which the
methods were called. When an appropriate handler is found, the runtime system
passes the exception to the handler. An exception handler is considered
appropriate if the type of the exception object thrown matches the type that
can be handled by the handler.

## Catch or Specify Requirement

## Three Kinds of Exceptions

1. Checked Exception: These are exceptional conditions that an application
   should anticipate and recover from.  Checked exceptions are subject to the
   Catch or Specify Requirement. All exceptions are checked exceptions, except
   for those indicated by `Error`, `RuntimeException`, and their subclasses.

2. Errors: These are exceptional conditions that are external to the
   application, and that the application usually cannot anticipate or recover
   from.

3. Runtime Exception:  These are exceptional conditions that are internal to
   the application, and that the application usually cannot anticipate or
   recover from. 


## Advantages of Exceptions

### Separating Error-Handling Code from "Regular" Code

### Propagating Errors Up the Call Stack

### Grouping and Differentiating Error Types:wa

