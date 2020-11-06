
```clojure
(try
  (/ 2 1)
  (catch ArithmeticException e
    "divide by zero")
  (finally
    (println "cleanup")))
```

```clojure
(try
  (throw (Exception. "something went wrong"))
  (catch Exception e (.getMessage e)))
```

**Exceptions with Clojure data**

- ex-info takes a message and a map
- ex-data gets the map back out (Or nil if not created with ex-info)

```clojure
(try
  (throw (ex-info "There was a problem" {:detail 42}))
  (catch Exception e
    (prn (:detail (ex-data e)))))
```

**with-open**

```clojure
(let [f (clojure.java.io/writer "/tmp/new")]
  (try
    (.write f "some text")
    (finally
      (.close f))))

;; Can be written:
(with-open [f (clojure.java.io/writer "/tmp/new")]
  (.write f "some text"))
```



