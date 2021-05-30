# Collections

The collections framework contain

- Interfaces: so they can be comnomly manipulated
- Implementations:  some standard implementations such as `LinkedList`, `HashSet`, and `TreeSet`
- Algorithms: methods such as searching and sorting


The framework defines serveral `map` (key/value pairs) interfaces and classes
(even though they don't implement Collection).


### Interfaces

| *Interface* | *Extends*  | *Descritpion*                                  |
| Collection  |            | Work with groups of objects, most basic        |
| List        | Collection | stores a ordered collection of elements        |
| Set         | Colection  | Contains unique elements                       |
| SortedSet   | Set        | Handles sorted sets                            |
| Map         |            | Maps unique keys to values                     |
| Map.Entry   |            | Describes an element (key/value pair) in a map |
| SortedMap   | Map        | Keys are in ascending order                    |
| Enumeration |            | Deprecated: Superceded by Iterator             |


### The Collection Classes

#### Abstract Classess 

Provides a skeletal implementation when creating your own concrete collections

| *Class*                | *Extends*          | *Implements*      | *Descritpion*                          |
| AbstractCollection     |                    | Collection (most) |                                        |
| AbstractList           | AbstractCollection | List (most)       |                                        |
| AbstractSequentialList | AbstractList       |                   | Sequential Access (rather than random) |
| AbstractSet            | AbstractCollection | Set (most)        |                                        |
| AbstractMap            |                    | Map (most)        |                                        |

#### Classes

Provide concrete classes ready-to-use


| *Class*         | *Extends*              | *Descritpion*                                   |
| LinkedList      | AbstractSequentialList |                                                 |
| ArrayList       | AbstractList           | Dynamic array                                   |
| HashSet         | AbstractSet            | Hash table                                      |
| LinkedHashSet   | HashSet                | Allows insertion-order iterations               |
| TreeSet         | AbstractSet            | Set stored in a tree                            |
| HashMap         | AbstractMap            |                                                 |
| TreeMap         | AbstractMap            | Map stored in a tree                            |
| WeakHashMap     | AbstractMap            | Hash table with weak keys                       |
| LinkedHashMap   | HashMap                | All insertion-order iterations                  |
| IdentityHashMap | Abstractmap            | Use reference equality when comparing documents |


*LinkedList vs ArrayList*

https://stackoverflow.com/questions/322715/when-to-use-linkedlist-over-arraylist

*HashSet vs TreeSet vs LinkedHashSet*

https://stackoverflow.com/questions/20116660/hashset-vs-treeset-vs-linkedhashset-on-basis-of-adding-duplicate-value

