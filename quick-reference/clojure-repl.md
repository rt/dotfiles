```bash
clj # clojure cli tools
# or,
lein repl # lein project management tool (there's also boot)
# or even
java -jar clojure.jar
```

**docker**
```bash
# starts nPEPL by default
docker run -it --rm clojure
```

```clojure

(defn factorial [n]
(if (= n 0)
  1
  (* n (factorial (dec n)))))

(factorial 10)

```

```clojure
(require '[clojure.string])
(clojure.string/upper-case "clojure")
```

### Reference

https://clojure.org/guides/repl/enhancing_your_repl_workflow
