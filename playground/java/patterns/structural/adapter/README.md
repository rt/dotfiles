# Adapter

used so that two unrelated interfaces can work together


The example code is putting an adapter around Socket to provide multiple voltage outputs.

While implementing Adapter pattern, there are two approaches – class adapter and object adapter – however both these approaches produce same result.

The SocketAdapter interface can be either a interface or abstract class

`SocketClassAdapterImpl`
Class Adapter – This form uses java inheritance and extends the source interface, in our case Socket class.

`SocketObjectAdapterImpl`
Object Adapter – This form uses Java Composition and adapter contains the source object.
