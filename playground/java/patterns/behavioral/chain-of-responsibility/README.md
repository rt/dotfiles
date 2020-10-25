# Chain of Responsibility

Chain of responsibility pattern is used to achieve loose coupling 
where a request from client is passed to a chain of objects to process
them. Then the object in the chain will decide themselves who will be
processing the request and whether the request is required to be sent to the
next object in the chain or not.


Try-catch block is similar.  So when any exception occurs in the try block, its
send to the first catch block to process. If the catch block is not able to
process it, it forwards the request to next object in chain i.e next catch
block. If even the last catch block is not able to process it, the exception is
thrown outside of the chain to the calling program.


## Example 


```
gradle build
cd build/classes/java/main
java ATMDispenseChain
```

The important point to note here is the implementation of dispense method. You
will notice that every implementation is trying to process the request and
based on the amount, it might process some or full part of it.

If one of the chain not able to process it fully, it sends the request to the
next processor in chain to process the remaining request. If the processor is
not able to process anything, it just forwards the same request to the next
chain.


Client doesn’t know which part of the chain will be processing the request and it will send the request to the first object in the chain. For example, in our program ATMDispenseChain is unaware of who is processing the request to dispense the entered amount.

Each object in the chain will have it’s own implementation to process the request, either full or partial or to send it to the next object in the chain.

Every object in the chain should have reference to the next object in chain to forward the request to, its achieved by java composition.

Creating the chain carefully is very important otherwise there might be a case that the request will never be forwarded to a particular processor or there are no objects in the chain who are able to handle the request. In my implementation, I have added the check for the user entered amount to make sure it gets processed fully by all the processors but we might not check it and throw exception if the request reaches the last object and there are no further objects in the chain to forward the request to. This is a design decision.

Chain of Responsibility design pattern is good to achieve lose coupling but it comes with the trade-off of having a lot of implementation classes and maintenance problems if most of the code is common in all the implementations.


## Examples in JDK

java.util.logging.Logger#log()
javax.servlet.Filter#doFilter()
