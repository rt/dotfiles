# Serialization

The serialization process is instance-independent, i.e. objects can be
serialized on one platform and deserialized on another. Classes that are
eligible for serialization need to implement a special marker interface
Serializable.

Both ObjectInputStream and ObjectOutputStream are high level classes that
extend java.io.InputStream and java.io.OutputStream respectively.
ObjectOutputStream can write primitive types and graphs of objects to an
OutputStream as a stream of bytes. These streams can subsequently be read using
ObjectInputStream.


- must implement `Serializable`
- static fields belong to a class (as opposed to an object) and are not serialized
- keyword `transient` will ignore class fields during serialization
- all sub-classes are serializable as well
- field object references must implement `Serializable` as well

*Serial Version UID*

The JVM associates a version (long) number with each serializable class. It is
used to verify that the saved and loaded objects have the same attributes and
thus are compatible on serialization.

This number can be generated automatically by most IDEs and is based on the
class name, its attributes and associated access modifiers. Any changes result
in a different number and can cause an InvalidClassException.

If a serializable class doesn’t declare a serialVersionUID, the JVM will
generate one automatically at run-time. However, it is highly recommended that
each class declares its serialVersionUID as the generated one is compiler
dependent and thus may result in unexpected InvalidClassExceptions.

*Custom Serialization*

Provide `writeObject` and `readObject`

Java specifies a default way in which objects can be serialized. Java classes
can override this default behavior. Custom serialization can be particularly
useful when trying to serialize an object that has some unserializable
attributes. This can be done by providing two methods inside the class that we
want to serialize:

```
public class Employee implements Serializable {
    private static final long serialVersionUID = 1L;
    private transient Address address;
    private Person person;
 
    // setters and getters
 
    private void writeObject(ObjectOutputStream oos) 
      throws IOException {
        oos.defaultWriteObject();
        oos.writeObject(address.getHouseNumber());
    }
 
    private void readObject(ObjectInputStream ois) 
      throws ClassNotFoundException, IOException {
        ois.defaultReadObject();
        Integer houseNumber = (Integer) ois.readObject();
        Address a = new Address();
        a.setHouseNumber(houseNumber);
        this.setAddress(a);
    }
}
```
