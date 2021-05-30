import java.io.*;
import static org.junit.Assert.*;
import java.io.*;

private  class Person implements Serializable {
    private static final long serialVersionUID = 1L;
    static String _country = "ITALY";
    private int _age;
    private String _name;
    transient int _height;


    public String getName() {
        return _name;
    }

    public void setName(String name) {
        _name = name;
    }
 
    public int getAge() {
        return _age;
    }

    public void setAge(int age) {
        _age = age;
    }
}

public class App {
    
    public static void main(String[] args) {
        Person person = new Person();
        person.setAge(20);
        person.setName("Joe");

        FileOutputStream fileOutputStream = new FileOutputStream("yourfile.txt");
        ObjectOutputStream objectOutputStream = new ObjectOutputStream(fileOutputStream);
        objectOutputStream.writeObject(person);
        objectOutputStream.flush();
        objectOutputStream.close();

        FileInputStream fileInputStream = new FileInputStream("yourfile.txt");
        ObjectInputStream objectInputStream = new ObjectInputStream(fileInputStream);
        Person p2 = (Person) objectInputStream.readObject();
        objectInputStream.close(); 

        // assertTrue(p2.getAge() == person.getAge());
        // assertTrue(p2.getName().equals(person.getName()));
    }
}
