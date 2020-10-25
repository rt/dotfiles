# Flyweight

Flyweight design pattern is used when we need to create a lot of Objects of a class. 
flyweight design pattern can be applied to reduce the load on memory by sharing objects.

To apply flyweight pattern, we need to divide Object property into intrinsic
and extrinsic properties. Intrinsic properties make the Object unique whereas
extrinsic properties are set by client code and used to perform different
operations. For example, an Object Circle can have extrinsic properties such as
color and width.


Example

For applying flyweight pattern, we need to create a Flyweight factory that
returns the shared objects. For our example, lets say we need to create a
drawing with lines and Ovals. So we will have an interface Shape and its
concrete implementations as Line and Oval. Oval class will have intrinsic
property to determine whether to fill the Oval with given color or not whereas
Line will not have any intrinsic property.

the delay is just to make the point that the object could take a long time to instantiate.


The flyweight factory will be used by client programs to instantiate the
Object, so we need to keep a map of Objects in the factory that should not be
accessible by client application.


Whenever client program makes a call to get an instance of Object, it should be
returned from the HashMap, if not found then create a new Object and put in the
Map and then return it. We need to make sure that all the intrinsic properties
are considered while creating the Object.


