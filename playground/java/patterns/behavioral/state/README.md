# State 

If we have to change the behavior of an object based on its state, we can have
a state variable in the Object. Then use if-else condition block to perform
different actions based on the state. State design pattern is used to provide a
systematic and loosely coupled way to achieve this through Context and State
implementations.

State Pattern Context is the class that has a State reference to one of the
concrete implementations of the State. Context forwards the request to the
state object for processing. 


## Exameple

Note: The TVRemoteBasic.java is showing what it would look like without the State Pattern.

Notice that Context also implements State and keep a reference of its current
state and forwards the request to the state implementation.


Similar to Strategy Pattern
