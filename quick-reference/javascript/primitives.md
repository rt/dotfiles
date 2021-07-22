# primitive

- not an object 
- has no methods
- primitives are immutable

There are 7 primitive data types: 
- string 
- number
- bigint 
- boolean 
- undefined 
- symbol 
- null


```javascript
// Using a string method doesn't mutate the string
var bar = "baz";
console.log(bar);               // baz
bar.toUpperCase();
console.log(bar);               // baz

// Using an array method mutates the array
var foo = [];
console.log(foo);               // []
foo.push("plugh");
console.log(foo);               // ["plugh"]

// Assignment gives the primitive a new (not a mutated) value
bar = bar.toUpperCase();       // BAZ
```

Except for null and undefined, all primitive values have object equivalents
that wrap around the primitive value

- String
- Number
- BigInt
- Boolean
- Symbol

`Autoboxing`: when you try to access a method on a primitive it is temporarily
converted to it's related built-in prototype object.
