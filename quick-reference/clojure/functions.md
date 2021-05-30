
defn defines a named function:

```clojure
;;    name   params         body
;;    -----  ------  -------------------
(defn greet  [name]  (str "Hello, " name) )
```

**Multi-arity functions**

```clojure
(defn messenger
  ([]     (messenger "Hello world!"))
  ([msg]  (println msg)))
```

**Variadic functions**

variable number of parameters 
They will be collected in a sequence for use by the function (`who` below).

```clojure
(defn hello [greeting & who]
  (println greeting who))

user=> (hello "Hello" "world" "class")
Hello (world class)
```

**Anonymous functions**

```clojure
(fn  [message]  (println message) )
(  (fn [message] (println message))  "Hello world!" ) ; immediately invoke it
```

**defn vs fn**

It might be useful to think of defn as a contraction of def and fn. The fn
defines the function and the def binds it to a name. These are equivalent:

```clojure
(defn greet [name] (str "Hello, " name))

(def greet (fn [name] (str "Hello, " name)))
```

**Anonymous function syntax**

There is a shorter form for the fn anonymous function syntax implemented in the
Clojure reader: #(). This syntax omits the parameter list and names parameters
based on their position.

- % is used for a single parameter
- %1, %2, %3, etc are used for multiple parameters
- %& is used for any remaining (variadic) parameters

```clojure
;; Equivalent to: (fn [x] (+ 6 x))
#(+ 6 %)

;; Equivalent to: (fn [x y] (+ x y))
#(+ %1 %2)

;; Equivalent to: (fn [x y & zs] (println x y zs))
#(println %1 %2 %&)
```

**Gotcha**

One common need is an anonymous function that takes an element and wraps it in a vector. You might try writing that as:

```clojure
;; DO NOT DO THIS
#([%])

;; would expand to. 
;; This form will wrap in a vector and try to invoke the vector with no arguments (the extra pair of parentheses).
(fn [x] ([x]))

;; Instead do this:
#(vector %)

;; or this:
(fn [x] [x])

;; or most simply just the vector function itself:
vector
```

**Applying functions**

The apply function invokes a function with 0 or more fixed arguments, and draws
the rest of the needed arguments from a final sequence. The final argument must
be a sequence.

```clojure
(apply f '(1 2 3 4))    ;; same as  (f 1 2 3 4)
(apply f 1 '(2 3 4))    ;; same as  (f 1 2 3 4)
(apply f 1 2 '(3 4))    ;; same as  (f 1 2 3 4)
(apply f 1 2 3 '(4))    ;; same as  (f 1 2 3 4)
```

All 4 of these calls are equivalent to (f 1 2 3 4). apply is useful when
arguments are handed to you as a sequence but you must invoke the function with
the values in the sequence.
