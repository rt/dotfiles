In Clojure, however, everything is an expression! Everything returns a value,
and a block of multiple expressions returns the last value. Expressions that
exclusively perform side-effects return nil.

**Truth**

All values are logically true or false. The only "false" values are
false and nil - all other values are logically true.


```clojure
;; if
(str "2 is " (if (even? 2) "even" "odd"))   ; 2 is even
(if (true? false) "impossible!") ;; else is optional


;; use if and do to create larger blocks (the only reason to do this is for side effects)
(if (even? 5)
  (do (println "even")
      true)
  (do (println "odd")
      false))

;; when communicates there is no "else" branch
(when (neg? x)
  (throw (RuntimeException. (str "x must be positive: " x))))

;; cond will return nill if no matches 
(let [x 5]
  (cond
    (< x 2) "x is less than 2"
    (< x 10) "x is less than 10"))
    :else "blah ..." ;; (common idiom) keywords always evaluate to true will be default

;; case will throw an exception if no matches (cases must be compile time literal)
(defn foo [x]
 (case x
   5 "x is 5"
   10 "x is 10"
   "x isn't 5 or 10")) ;; trailing expression that will be evaluated if no test matches.
```

**Iteration for Side Effects**

```clojure

;; dotimes: returns nill
(dotimes [i 3]
  (println i))

;; doseq: iterate over sequence, if lazy sequence force evaluation, returns nil
(doseq [n (range 3)]
  (println n))

;; doseq multiple bindings: processes all permutations of sequence content (like nested foreach)
(doseq [letter [:a :b]
        number (range 3)] ; list of 0, 1, 2
  (prn [letter number]))

;; for: list comprehension (not a for-loop), generator function for sequence permutation, bindings behave like doseq
user=> (for [letter [:a :b]
             number (range 3)] ; list of 0, 1, 2
         [letter number])
([:a 0] [:a 1] [:a 2] [:b 0] [:b 1] [:b 2])

```
