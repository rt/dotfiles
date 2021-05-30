**Groovy implicitly creates getters, setter methods, and provides constructors with arguments.**
```groovy
class Person {
  String name;
  int ID;
}
class Test {
  static void main(String) {
    def emp = new emp(name: 'name’')
    println emp.getName();
    emp.setYR(2019);
    println emp.getYR(); // 2019
  }
}
```
