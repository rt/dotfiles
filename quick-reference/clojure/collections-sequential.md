Of four key colletions types (vectors, lists, sets, maps) vectors and lists are ordered.

**Vectors**
Vectors are an indexed, sequential data structure.

```clojure
;; Construct
[1 2 3] ; literal
(vector 1 2 3) ; with vector function

;; get
(get ["abc" false 99] 0)  ; "abc"
(get ["abc" false 99] 14) ; nil

;; count
(count [1 2 3])   ; 3

;; conjoin
(conj [1 2 3] 4 5 6)  ; [1 2 3 4 5 6]
```

**Lists**

Lists are sequential linked lists that add new elements at the head of the
list, instead of at the tail like vectors.

Because lists are evaluated by invoking the first element as a function, we
must quote a list to prevent evaluation:

```clojure
;; Construct
(def cards '(10 :ace :jack 9))

;; not indexed so they must be walked
(first cards)         ; 10
(rest cards)          ; '(:ace :jack 9)

;; conjoin
(conj cards :queen)   ; (:queen 10 :ace :jack 9)

;; stack access
(def stack '(:a :b))
(peek stack)          ; :a
(pop stack)           ; (:b)
```

**other**

someone's mention on reddit ...

In many cases I find the flow of data starts with collections, then moves into
sequences (as a result of applying sequence functions), and then sometimes back
to collections when it comes to rest (via into, vec, or set). Transducers have
changed this a bit as they allow you to separate the target collection from the
transformation and thus it's much easier to stay in collections all the time
(if you want to) by apply into with a transducer.

When I am building up or working on collections, typically the code
constructing it is "close" and the collection types are known and obvious.
Generally sequential data is far more likely to be vectors and conj will
suffice.

When I am thinking in "sequences", it's very rare for me to do an operation
like "add last" - instead I am thinking in whole collection terms.

If I do need to do something like that, then I would probably convert back to
collections (via into or vec) and use conj again.


...

each function represents a fundamentally different action with a differing
fundamental motivation. If you're calling conj, it's because you want to build
onto an existing collection. If you're calling concat, you want to merge
existing collections. Calling Seq says that you want to get an iterator over an
existing collection, usually for later consumption. While all of these
Functions do yield sequences or collections, they represent distinct idioms.
