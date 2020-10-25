# Abstract Factory

This factory class returns different subclasses based on the input provided and
factory class uses if-else or switch statement to achieve this.

In Abstract Factory pattern, we get rid of if-else block and have a factory
class for each sub-class. Then an Abstract Factory class that will return the
sub-class based on the input factory class. At first it seems confusing but
once you see the implementation, its really easy to grasp and understand the
minor difference between Factory and Abstract Factory pattern.


You won't have the long if else statements (or switch).  And, you the logic can
grow with multiple params and instantiation logic.  With Abstract Factory you
provide the params for the sub classed factory up front and get the correct
instance.

Its imaginable you could use a builder pattern to create the sub class factory ... mixing is fine
