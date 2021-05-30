**Calling into java**

| Task            | Java              | Clojure          |
| Instantiation   | new Widget("foo") | (Widget. "foo")  |
| Instance method | rnd.nextInt()     | (.nextInt rnd)   |
| Instance field  | object.field      | (.-field object) |
| Static method   | Math.sqrt(25)     | (Math/sqrt 25)   |
| Static field    | Math.PI           | Math/PI          |

**Java methods vs functions**

- Java methods are not Clojure functions
- Can’t store them or pass them as arguments
- Can wrap them in functions when necessary

```clojure
;; make a function to invoke .length on arg
(fn [obj] (.length obj))

;; same thing
#(.length %)
```
