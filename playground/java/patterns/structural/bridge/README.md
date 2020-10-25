# Bridge

https://sourcemaking.com/design_patterns/bridge

> Decouple an abstraction from its implementation so that the two can vary independently
>


When we have interface hierarchies in both interfaces as well as
implementations, then bridge design pattern is used to decouple the interfaces
from implementation and hiding the implementation details from the client
programs.

Bridge design pattern can be used when both abstraction and implementation can
have different hierarchies independently and we want to hide the implementation
from the client application.




Decompose the component's interface and implementation into orthogonal class
hierarchies. The interface class contains a pointer to the abstract
implementation class. This pointer is initialized with an instance of a
concrete implementation class, but all subsequent interaction from the
interface class to the implementation class is limited to the abstraction
maintained in the implementation base class. The client interacts with the
interface class, and it in turn "delegates" all requests to the implementation
class.

The interface object is the "handle" known and used by the client; while the
implementation object, or "body", is safely encapsulated to ensure that it may
continue to evolve, or be entirely replaced (or shared at run-time.

Use the Bridge pattern when:

- you want run-time binding of the implementation,
- you have a proliferation of classes resulting from a coupled interface and numerous implementations,
- you want to share an implementation among multiple objects,
- you need to map orthogonal class hierarchies.

Consequences include:

- decoupling the object's interface,
- improved extensibility (you can extend (i.e. subclass) the abstraction and implementation hierarchies independently),
- hiding details from clients.

Bridge is a synonym for the "handle/body" idiom. This is a design mechanism
that encapsulates an implementation class inside of an interface class. The
former is the body, and the latter is the handle. The handle is viewed by the
user as the actual class, but the work is done in the body. "The handle/body
class idiom may be used to decompose a complex abstraction into smaller, more
manageable classes. The idiom may reflect the sharing of a single resource by
multiple classes that control access to it (e.g. reference counting)."



Adapter makes things work after they're designed; Bridge makes them work before
they are.

Bridge is designed up-front to let the abstraction and the implementation vary
independently. Adapter is retrofitted to make unrelated classes work together.

State, Strategy, Bridge (and to some degree Adapter) have similar solution
structures. They all share elements of the "handle/body" idiom. They differ in
intent - that is, they solve different problems.

The structure of State and Bridge are identical (except that Bridge admits
hierarchies of envelope classes, whereas State allows only one). The two
patterns use the same structure to solve different problems: State allows an
object's behavior to change along with its state, while Bridge's intent is to
decouple an abstraction from its implementation so that the two can vary
independently.

If interface classes delegate the creation of their implementation classes
(instead of creating/coupling themselves directly), then the design usually
uses the Abstract Factory pattern to create the implementation objects.

Example

Notice the bridge between Shape and Color interfaces and use of composition in
implementing the bridge pattern.

