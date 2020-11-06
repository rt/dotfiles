https://clojure.org/api/cheatsheet

```clojure
user=> (def x 7)
#'user/x
```

def is a special form that associates a symbol (x) in the current namespace
with a value (7). This linkage is called a var. In most actual Clojure code,
vars should refer to either a constant value or a function

Note the return value above is #'user/x - that’s the literal representation for
a var: #' followed by the namespaced symbol. user is the default namespace.

**Printing**

`print/println`

```clojure
user=> (println "What is this:" (+ 1 2))
What is this: 3
```

The println function has side-effects (printing) and returns nil as a result.

Note that "What is this:" above did not print the surrounding quotes and is not
a string that the Reader could read again as data.

Use `pr/prn` to print as data

```clojure
user=> (prn "one\n\ttwo")
"one\n\ttwo"
```

**Delaying evaluation with quoting**

Sometimes it’s useful to suspend evaluation, in particular for symbols and
lists. Sometimes a symbol should just be a symbol without looking up what it
refers to:

```clojure
user=> 'x
x

user=> '(1 2 3)
(1 2 3)
```

**Executing**

```bash
#! /usr/bin/env clj
(prn "Hello, world")
```

```bash
lein uberjar
java -jar <artifact-name>.jar
```
