import org.junit.Test;
import static org.junit.Assert.*;
import java.io.*;

public class AppTest {

    @Test
    public void whenSerializingAndDeserializing_ThenObjectIsTheSame() throws IOException, ClassNotFoundException { 
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

        assertTrue(p2.getAge() == person.getAge());
        assertTrue(p2.getName().equals(person.getName()));
    }
}

