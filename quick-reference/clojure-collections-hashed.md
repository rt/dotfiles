designed for efficient lookup of elements

**Sets**

```clojure
(def players #{"Alice", "Bob", "Kelly"})

;; conjoin
(conj players "Fred")       ; #{"Alice" "Fred" "Bob" "Kelly"}

;; remove/disjoin
(disj players "Bob" "Sal")  ; #{"Alice" "Kelly"}

;; contains
(contains? players "Kelly") ; true

;; sorted (custom comparators can be used with `sorted-set-by`
(conj (sorted-set) "Bravo" "Charlie" "Sigma" "Alpha")   ; #{"Alpha" "Bravo" "Charlie" "Sigma"}

;; into (returns a collection of the same type as its first argument)
(def players #{"Alice" "Bob" "Kelly"})
(def new-players ["Tim" "Sue" "Greg"])
(into players new-players)  ; #{"Alice" "Greg" "Sue" "Bob" "Tim" "Kelly"}
```

**Maps**

Maps are commonly used for two purposes - to manage an association of keys to
values and to represent domain application data.

```clojure
(def scores {"Fred"  1400
             "Bob"   1240
             "Angela" 1024})
;; same
(def scores {"Fred" 1400, "Bob" 1240, "Angela" 1024})

;; adding/replacing (assoc)
(assoc scores "Sally" 0)  ; {"Angela" 1024, "Bob" 1240, "Fred" 1400, "Sally" 0}

;; removing (dissoc)
(dissoc scores "Bob")     ; {"Angela" 1024, "Fred" 1400}

;; lookup (get)
(get scores "Angela")     ; 1024

;; When the map in question is being treated as a constant lookup table, its
;; common to invoke the map itself, treating it as a function:
(def directions {:north 0
                 :east 1
                 :south 2
                 :west 3})
(directions :north)       ; 0

;; with default
(get scores "Sam" 0)

;; contains
(contains? scores "Fred") ; true

;; find (return entry)
(find scores "Fred")      ; ["Fred" 1400]

(keys scores) ;; keys
(vals scores) ;; vals

;; "zip" together two sequences (the keys and vals) into a map
(def players #{"Alice" "Bob" "Kelly"})
(zipmap players (repeat 0)) ; {"Kelly" 0, "Bob" 0, "Alice" 0}

;; other ways to build up a map using sequence functions
;; with map and into
(into {} (map (fn [player] [player 0]) players))

;; with reduce
(reduce (fn [m player]
          (assoc m player 0))
        {} ; initial value
        players)

;; combining maps (can pass multiple, rightmost wins)
(def new-scores {"Angela" 300 "Jeff" 900})
(merge scores new-scores)   ; {"Fred" 1400, "Bob" 1240, "Jeff" 900, "Angela" 300}

;; If both maps contain the same key, the rightmost one wins. Alternately, you can use merge-with to supply a function to invoke when there is a conflict
(def new-scores {"Fred" 550 "Angela" 900 "Sam" 1000})
(merge-with + scores new-scores)  ; {"Sam" 1000, "Fred" 1950, "Bob" 1240, "Angela" 1924}

;; sorted maps (sililar to sorted sets, comparator)
(def sm (sorted-map
         "Bravo" 204
         "Alfa" 35
         "Sigma" 99
         "Charlie" 100))    ; {"Alfa" 35, "Bravo" 204, "Charlie" 100, "Sigma" 99}

(keys sm)                   ; ("Alfa" "Bravo" "Charlie" "Sigma")
(vals sm)                   ; (35 204 100 99)
```

**Representing application domain info**

Use keyword keys

```clojure
(def person
  {:first-name "Kelly"
   :last-name "Keen"
   :age 32
   :occupation "Programmer"})

;; keywords are also functions, this is the most common way to get field values (even though normal map access is possible)
(:occupation person)    ; "Programmer"

;; with default
(:favorite-color person "beige")  ; "beige"
```


**Nested**

```clojure
(def company
  {:name "WidgetCo"
   :address {:street "123 Main St"
             :city "Springfield"
             :state "IL"}})

;; manipulating nested entries
(get-in company [:address :city])   ; "Springfield"
(assoc-in company [:address :street] "303 Broadway") ; insert at path
```

**Records**

An alternative to using maps is to create a "record". Records are designed
specifically for this use case and generally have better performance. In
addition, they have a named "type" which can be used for polymorphic behavior
(more on that later).

Records are defined with the list of field names for record instances. These
will be treated as keyword keys in each record instance.

Records are used almost exactly the same as maps, with the caveat that they
cannot be invoked as a function like maps.

```clojure
;; Define a record structure
(defrecord Person [first-name last-name age occupation])

;; Positional constructor - generated
(def kelly (->Person "Kelly" "Keen" 32 "Programmer"))

;; Map constructor - generated
(def kelly (map->Person
             {:first-name "Kelly"
              :last-name "Keen"
              :age 32
              :occupation "Programmer"}))
```
