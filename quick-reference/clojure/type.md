**Numeric types**

```clojure
42        ; integer
-1.5      ; floating point
22/7      ; ratio
```
Integers and floats have arbitrary precision, can be forces with trailing N or M.
Clojure also supports the Java syntax for octal (prefix 0), hexadecimal (prefix
0x) and arbitrary radix (prefix with base then r) integers.

The special symbolic values ##Inf, ##-Inf, and ##NaN represent positive
infinity, negative infinity, and "not a number" values respectively.

**Character types***

```clojure
"hello"         ; string, can span multiple lines
\e              ; character
#"[0-9]+"       ; regular expression, compiled to java.util.regex.Pattern objects
```

There are a few special named characters: \newline \spec \tab, etc. Unicode
characters can be represented with \uNNNN or in octal with \oNNN.

**Symbols and idents**

```clojure
map             ; symbol
+               ; symbol - most punctuation allowed
clojure.core/+  ; namespaced symbol
nil             ; null value
true false      ; booleans
:alpha          ; keyword
:release/alpha  ; keyword with namespace
```

Keywords start with a leading colon and always evaluate to themselves. They are
frequently used as enumerated values or attribute names in Clojure.

**Literal collections**

```clojure
'(1 2 3)     ; list
[1 2 3]      ; vector
#{1 2 3}     ; set
{:a 1, :b 2} ; map
```
