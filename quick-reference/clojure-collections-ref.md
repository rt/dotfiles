|                | Vector  | List    | Map   | Set   |
| Combine        | concat  | concat  | merge | union |
| Prepend        | (don't) | conj    | N/A   | N/A   |
| Append         | conj    | (don't) | N/A   | N/A   |
| Add or replace | N/A     | N/A     | conj  | conj  |

**Which should I apply**

|        | Conj | Cons | Concat | Into | Merge | Assoc | Union |
| Vector | y    | y    | y      | y    | n     | y     | n     |
| List   | y    | y    | y      | y    | n     | n     | n     |
| Map    | y    | n    | n      | y    | y     | y     | n     |
| Set    | y    | n    | n      | y    | n     | n     | y     |

The formal definition of the seq interface is anything that responds to first
and rest. At a practical level, all of the common data structures (vector,
list, map, set) are collections, and list is also a concrete implementation of
seq. Furthermore, all of the non-seq collections can be converted to a seq
using (seq coll). A note on performance: count is an expensive operation, O(n),
on a seq (which might be infinite). In contrast, count is constant, O(1), for a
collection.

“A good rule of thumb is that if you need to easily add items to the beginning
of a sequence or if you’re writing a macro, you should use a list. Otherwise,
you should use a vector.“

https://medium.com/@greg_63957/conj-cons-concat-oh-my-1398a2981eab

https://stackoverflow.com/questions/3008411/clojure-cons-seq-vs-conj-list
