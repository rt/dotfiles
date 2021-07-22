
internal slots [[ ]] 
 - correspond to intenal state
 - not properties

 to kinds of internal slots
 - methods for manipulating objects (getting, setting ..)
 - data that store values

 ordinary objects have
 - [[Prototype]]: null | object
 - [[Extensible]]: boolean
 - [[PrivateFieldValues]]: EntryList

 key is either
 - string
 - symbol

 two kinds of properties and they are characterized by their attibutes
 - data property
 - accessor property




| Kind of property  | Name and type of attribute       | Default value |
-----
| Data property     | value: any                       | undefined     |
|                   | writable: boolean                | false         |
| Accessor property | get: (this: any) => any          | undefined     |
|                   | set: (this: any, v: any) => void | undefined     |
| All properties    | configurable: boolean            | false         |
|                   | enumerable: boolean              | false         |


- writable determines if the value of a data property can be changed.
- configurable determines if the attributes of a property can be changed. If it is false, then:
-   We cannot delete the property.
-   We cannot change a property from a data property to an accessor property or vice versa.
-   We cannot change any attribute other than value.
-   However, one more attribute change is allowed: We can change writable from true to false. 
-     The rationale behind this anomaly is historical: 
-     Property .length of Arrays has always been writable and non-configurable. 
-     Allowing its writable attribute to be changed enables us to freeze Arrays.
- enumerable influences some operations (such as Object.keys()). 
-   If it is false, then those operations ignore the property. 
-   Most properties are enumerable (e.g. those created via assignment or object literals), 
-   which is why you’ll rarely notice this attribute in practice.
