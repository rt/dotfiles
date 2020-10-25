# Mediator

Mediator design pattern is used to provide a centralized communication medium
between different objects in a system.


GoF

> Allows loose coupling by encapsulating the way disparate sets of objects
> interact and communicate with each other. Allows for the actions of each object
> set to vary independently of one another.

## my notes

Different from visitor pattern in that this is seeded with a mediator, then used in multiple places.
The visitor pattern passes the logic to the method as a parameter.  However, they are the same in
that the logic implementation is in a class of its own.


The objects can extend an abstract class (as in this example) or use and interface
