import java.io.*;

public class Person implements Serializable {
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
