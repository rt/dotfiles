
# Variables and Datatypes

Let's look at the different datatypes and how they are used in programs with variables.

We can do all this in the REPL.

## Data Types

Based on the data type of a variable, the operating system allocates memory.

### Primitive 

There are eight primitive data types.

byte
- Byte data type is an 8-bit signed two's complement integer
- Minimum value is -128 (-2^7)
- Maximum value is 127 (inclusive)(2^7 -1)
- Default value is 0
- Byte data type is used to save space in large arrays, mainly in place of integers, since a byte is four times smaller than an integer.
- Example: byte a = 100, byte b = -50

short
- Short data type is a 16-bit signed two's complement integer
- Minimum value is -32,768 (-2^15)
- Maximum value is 32,767 (inclusive) (2^15 -1)
- Short data type can also be used to save memory as byte data type. A short is 2 times smaller than an integer
- Default value is 0.
- Example: short s = 10000, short r = -20000

int
- Int data type is a 32-bit signed two's complement integer.
- Minimum value is - 2,147,483,648 (-2^31)
- Maximum value is 2,147,483,647(inclusive) (2^31 -1)
- Integer is generally used as the default data type for integral values unless there is a concern about memory.
- The default value is 0
- Example: int a = 100000, int b = -200000

long
- Long data type is a 64-bit signed two's complement integer
- Minimum value is -9,223,372,036,854,775,808(-2^63)
- Maximum value is 9,223,372,036,854,775,807 (inclusive)(2^63 -1)
- This type is used when a wider range than int is needed
- Default value is 0L
- Example: long a = 100000L, long b = -200000L

float
- Float data type is a single-precision 32-bit IEEE 754 floating point
- Float is mainly used to save memory in large arrays of floating point numbers
- Default value is 0.0f
- Float data type is never used for precise values such as currency
- Example: float f1 = 234.5f

double
- double data type is a double-precision 64-bit IEEE 754 floating point
- This data type is generally used as the default data type for decimal values, generally the default choice
- Double data type should never be used for precise values such as currency
- Default value is 0.0d
- Example: double d1 = 123.4

boolean
- boolean data type represents one bit of information
- There are only two possible values: true and false
- This data type is used for simple flags that track true/false conditions
- Default value is false
- Example: boolean one = true

char
- char data type is a single 16-bit Unicode character
- Minimum value is '\u0000' (or 0)
- Maximum value is '\uffff' (or 65,535 inclusive)
- Char data type is used to store any character
- Example: char letterA = 'A'

### Reference/Object

-Reference variables are created using defined constructors of the classes. They are used to access objects. These variables are declared to be of a specific type that cannot be changed. For example, Employee, Puppy, etc.
-Class objects and various type of array variables come under reference datatype.
-Default value of any reference variable is null.
-A reference variable can be used to refer any object of the declared type or any compatible type.
-Example: Animal animal = new Animal("giraffe");

### Literals

A literal represent a fixed value.  They can be assigned any primitive type value.

```
byte a = 68;
char a = 'A';
```
byte, int, long, and short can be expressed in decimal(base 10), hexadecimal(base 16) or octal(base 8) number systems as well.

Prefix 0 is used to indicate octal, and prefix 0x indicates hexadecimal when using these number systems for literals.

```
int dec = 100;
int oct = 0144;
int hex = 0x64;
```

String literals in Java are specified like they are in most other languages by enclosing a sequence of characters between a pair of double quotes. Examples of string literals are −
```
"Hello World"
"two\nlines"
"\"This is in quotes\""
```

String and char types of literals can contain any Unicode characters. For example −
```
char a = '\u0001';
String a = "\u0001";
```

Escape sequences for string and char literals.
| Notation                                     | Representation                       |
| \n                                           | Newline (0x0a)                       |
| \r                                           | Carriage return (0x0d)               |
| \f                                           | Formfeed (0x0c)                      |
| \b                                           | Backspace (0x08)                     |
| \s                                           | Space (0x20)                         |
| \t                                           | tab                                  |
| \"                                           | Double quote                         |
| \'                                           | Single quote                         |
| \\                                           | backslash                            |
| \ddd	Octal character (ddd)                  | Octal charater (ddd)                 |
| \uxxxx	Hexadecimal UNICODE character (xxxx) | Hexadecimal UNICODE character (xxxx) |

Note:  Lines end with \r\n on Windows but \n on *nix systems
Note: Currently x86 and i64 architectures have 16/32/64 bit word so Hexadecimal is common (but no longer Octal)

## Variables

A variable provides us with named storage that our programs can manipulate.
Each variable in Java has a specific type, which determines the size and layout
of the variable's memory; the range of values that can be stored within that
memory; and the set of operations that can be applied to the variable.

You must declare all variables before they can be used.  They can optionally be assigned values.
```
data type variable [ = value][, variable [ = value] ...] ;
```

```
int a, b, c;         // Declares three ints, a, b, and c.
int a = 10, b = 10;  // Example of initialization
byte B = 22;         // initializes a byte type variable B.
double pi = 3.14159; // declares and assigns a value of PI.
char a = 'a';        // the char variable a iis initialized with value 'a'
```
