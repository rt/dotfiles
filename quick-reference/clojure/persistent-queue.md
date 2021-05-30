https://admay.github.io/queues-in-clojure/

```clojure
(defn queue
  ([] (clojure.lang.PersistentQueue/EMPTY))
  ([coll]
    (reduce conj clojure.lang.PersistentQueue/EMPTY coll)))


;; We'll use `conj` to add to the structure
;; And then `seq` to look at the queues contents

(def numbers-in (conj queue 1 2 3 4 5)
(seq numbers-in)
;;=> (1 2 3 4 5)

;; We can use `pop` and `peek` as expected

(peek numbers-in)
;;=> 1

(seq (pop numbers-in))
;;=> (2 3 4 5)

;; And `empty?` can be used to check if the queue is empty.

(empty? numbers-in)
;;=> false

(empty? (queue))
;;=> true
```


