**Scopes (collections, array)**
```groovy
def arg = ["Groovy","Java","Python",”nodeJS”]
println arg.class
println arg[1]
```

**List methods**

note: some mutate and some don't
Add( ), Get( ) Contains( ) Minus( ) Plus ( ) Pop( ) Remove( ) Reverse() Size( ) Sort( ) 

```groovy
def list = [];
list = [1, 2, 3, 4];
list.add(5); //add
list.pop(); //pop
```

**Add/remove collections from collections**

```groovy
def no = [1,2,3,4]
def no2 = no +5 //=[1,2,3,4,5]
def no3 = no - [2,3] //=[1,4]
```

**Different ways to add elemenets to collections**
```groovy
arg.add("Ruby")
arg << "Smalltalk"
arg[5] = "C++"
```

