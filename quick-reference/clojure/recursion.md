
**loop and recur**

- recur must be in "tail position", last expression in branch
- recur must provide values for all bound symbols by position
- Recursion via recur does not consume stack

```clojure
;; recur is classic recursion, consumers don't conroll it, considered a lower-level facility
(loop [i 0] ;; define bindings
  (if (< i 10)
    (recur (inc i)) ;; re-executes loop with new bindings
    i))

;; defn and recur
(defn increase [i] ;; function aguments are implicit loop bindings
  (if (< i 10)
    (recur (inc i))
    i))
```
