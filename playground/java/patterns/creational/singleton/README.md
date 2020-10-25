# Singleton

https://www.journaldev.com/1377/java-singleton-design-pattern-best-practices-examples


- Singleton pattern restricts the instantiation of a class and ensures that only one instance of the class exists in the java virtual machine.
- The singleton class must provide a global access point to get the instance of the class.
- Singleton pattern is used for logging, drivers objects, caching and thread pool.
- Singleton design pattern is also used in other design patterns like Abstract Factory, Builder, Prototype, Facade etc.
- Singleton design pattern is used in core java classes also, for example java.lang.Runtime, java.awt.Desktop.


Different approaches but all do the following

- Private constructor to restrict instantiation of the class from other classes.
- Private static variable of the same class that is the only instance of the class.
- Public static method that returns the instance of the class, this is the global access point for outer world to get the instance of the singleton class.


Some approaches (some outdated)

- Eager initialization (naive)
```
public class EagerInitializedSingleton {
    
    private static final EagerInitializedSingleton instance = new EagerInitializedSingleton();
    
    //private constructor to avoid client applications to use constructor
    private EagerInitializedSingleton(){}

    public static EagerInitializedSingleton getInstance(){
        return instance;
    }
}
```

- Static block initialization (in static block, still eager ...)
```
public class StaticBlockSingleton {

    private static StaticBlockSingleton instance;
    
    private StaticBlockSingleton(){}
    
    //static block initialization for exception handling
    static{
        try{
            instance = new StaticBlockSingleton();
        }catch(Exception e){
            throw new RuntimeException("Exception occured in creating singleton instance");
        }
    }
    
    public static StaticBlockSingleton getInstance(){
        return instance;
    }
}
```

- Lazy Initialization
```
public class LazyInitializedSingleton {

    private static LazyInitializedSingleton instance;

    private LazyInitializedSingleton(){}

    public static LazyInitializedSingleton getInstance(){
        if(instance == null){
            instance = new LazyInitializedSingleton();
        }
        return instance;
    }
}
```

- Thread Safe Singleton


```
public class ThreadSafeSingleton {

    private static ThreadSafeSingleton instance;
    
    private ThreadSafeSingleton(){}
    
    public static synchronized ThreadSafeSingleton getInstance(){
        if(instance == null){
            instance = new ThreadSafeSingleton();
        }
        return instance;
    }
    
}
```

Above implementation works fine and provides thread-safety but it reduces the
performance because of cost associated with the synchronized method, although
we need it only for the first few threads who might create the separate
instances (Read: Java Synchronization). To avoid this extra overhead every
time, double checked locking principle is used. In this approach, the
synchronized block is used inside the if condition with an additional check to
ensure that only one instance of singleton class is created.

```
public static ThreadSafeSingleton getInstanceUsingDoubleLocking(){
    if(instance == null){
        synchronized (ThreadSafeSingleton.class) {
            if(instance == null){
                instance = new ThreadSafeSingleton();
            }
        }
    }
    return instance;
}
```

- Bill Pugh Singleton Implementation

Prior to Java 5, java memory model had a lot of issues and above approaches
used to fail in certain scenarios where too many threads try to get the
instance of the Singleton class simultaneously. So Bill Pugh came up with a
different approach to create the Singleton class using a inner static helper
class. The Bill Pugh Singleton implementation goes like this;

```
public class BillPughSingleton {

    private BillPughSingleton(){}

    private static class SingletonHelper{
        private static final BillPughSingleton INSTANCE = new BillPughSingleton();
    }

    public static BillPughSingleton getInstance(){
        return SingletonHelper.INSTANCE;
    }
}

``` 

Notice the private inner static class that contains the instance of the
singleton class. When the singleton class is loaded, SingletonHelper class is
not loaded into memory and only when someone calls the getInstance method, this
class gets loaded and creates the Singleton class instance.

This is the most widely used approach for Singleton class as it doesn’t require
synchronization. I am using this approach in many of my projects and it’s easy
to understand and implement also.

- Using Reflection to destroy Singleton Pattern

Reflection can be used to destroy all the above singleton implementation
approaches. Let’s see this with an example class.

```
import java.lang.reflect.Constructor;

public class ReflectionSingletonTest {

    public static void main(String[] args) {
        EagerInitializedSingleton instanceOne = EagerInitializedSingleton.getInstance();
        EagerInitializedSingleton instanceTwo = null;
        try {
            Constructor[] constructors = EagerInitializedSingleton.class.getDeclaredConstructors();
            for (Constructor constructor : constructors) {
                //Below code will destroy the singleton pattern
                constructor.setAccessible(true);
                instanceTwo = (EagerInitializedSingleton) constructor.newInstance();
                break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(instanceOne.hashCode());
        System.out.println(instanceTwo.hashCode());
    }

}
```

When you run the above test class, you will notice that hashCode of both the
instances are not same that destroys the singleton pattern. Reflection is very
powerful and used in a lot of frameworks like Spring and Hibernate, do check
out Java Reflection Tutorial.

- Enum Singleton

To overcome this situation with Reflection, Joshua Bloch suggests the use of
Enum to implement Singleton design pattern as Java ensures that any enum value
is instantiated only once in a Java program. Since Java Enum values are
globally accessible, so is the singleton. The drawback is that the enum type is
somewhat inflexible; for example, it does not allow lazy initialization.

```
public enum EnumSingleton {

    INSTANCE;
    
    public static void doSomething(){
        //do something
    }
}
```

- Serialization and Singleton

Sometimes in distributed systems, we need to implement Serializable interface
in Singleton class so that we can store it’s state in file system and retrieve
it at later point of time. Here is a small singleton class that implements
Serializable interface also.

```
import java.io.Serializable;

public class SerializedSingleton implements Serializable{

    private static final long serialVersionUID = -7604766932017737115L;

    private SerializedSingleton(){}
    
    private static class SingletonHelper{
        private static final SerializedSingleton instance = new SerializedSingleton();
    }
    
    public static SerializedSingleton getInstance(){
        return SingletonHelper.instance;
    }
    
}

```

The problem with above serialized singleton class is that whenever we
deserialize it, it will create a new instance of the class. Let’s see it with a
simple program.

```
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectInputStream;
import java.io.ObjectOutput;
import java.io.ObjectOutputStream;

public class SingletonSerializedTest {

    public static void main(String[] args) throws FileNotFoundException, IOException, ClassNotFoundException {
        SerializedSingleton instanceOne = SerializedSingleton.getInstance();
        ObjectOutput out = new ObjectOutputStream(new FileOutputStream(
                "filename.ser"));
        out.writeObject(instanceOne);
        out.close();
        
        //deserailize from file to object
        ObjectInput in = new ObjectInputStream(new FileInputStream(
                "filename.ser"));
        SerializedSingleton instanceTwo = (SerializedSingleton) in.readObject();
        in.close();
        
        System.out.println("instanceOne hashCode="+instanceOne.hashCode());
        System.out.println("instanceTwo hashCode="+instanceTwo.hashCode());
        
    }

}
```

The output of the program is different hash codes.  To overcome this scenario all we need to do is provide the 
implemenation of readResolve() method

```
protected Object readResolve() {
    return getInstance();
}
```
