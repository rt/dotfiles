# Visitor

Visitor pattern is used when we have to perform an operation on a group of
similar kind of Objects. With the help of visitor pattern, we can move the
operational logic from the objects to another class.


## my notes

In the past, where i would try to solve everything with a super or abstract class,
each item could override its own logic for a method/operation.  This pattern
gives you a chance to put that logic into one class where it might be better managed.
This would give the ability to change the behavior by swapping a visitor class as well.

Definitely has similarities with Stategy Pattern.  Strategy Pattern is more 1:many while
this could be done for many methods on the object (many:many)
