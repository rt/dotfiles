**let**

let binds symbols to values in a "lexical scope". A lexical scope creates a new
context for names, nested inside the surrounding context. Names defined in a
let take precedence over the names in the outer context.

```clojure
;;      bindings     name is defined here
;;    ------------  ----------------------
(let  [name value]  (code that uses name))
```

Each let can define 0 or more bindings and can have 0 or more expressions in the body.

```clojure
(let [x 1
      y 2]
  (+ x y))
```

```clojure
(defn messenger [msg]
  (let [a 7
        b 5
        c (clojure.string/capitalize msg)]
    (println a b c)
  ) ;; end of let scope
) ;; end of function
```

The messenger function takes a msg argument. Here the defn is also creating
lexical scope for msg - it only has meaning within the messenger function.

**Closures**

The fn special form creates a "closure". It "closes over" the surrounding
lexical scope (like msg, a, b, or c above) and captures their values beyond the
lexical scope.

```clojure
(defn messenger-builder [greeting]
  (fn [who] (println greeting who))) ; closes over greeting

;; greeting provided here, then goes out of scope
(def hello-er (messenger-builder "Hello"))

;; greeting value still available because hello-er is a closure
(hello-er "world!")
;; Hello world!
```
