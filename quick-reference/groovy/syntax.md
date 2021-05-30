```groovy
def str = "Hello world"
def num =0
```

```groovy
for(x in 1..5){
  println x //0,1,2,3,4,5
}
```

**Default params**
```groovy
def repeat(val, x=10){
  for(i in 0..<x){
    println val
  }
}
```

**Groovy arithmetic operators, logical operators, relational operators and bitwise operators are all consistent with languages like nodeJS**

```groovy
String str1 = "123";
String str2 = new String("123");
if(str1 == str2){
  println(“equal")；
}else{
  println("Not equal")；
}
```

```groovy
Try{
.....
}catch(Exception1 exp){
.....
}finally{
......
}
```

