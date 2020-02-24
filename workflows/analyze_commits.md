# Analyze Commits

If you are the architect, repo master you might want to browse commits.

*Glog*
```
:Glog       //load all previous revisions of the current file into the quickfix list (:cprev :cnext :cfirst :clast)  unimpaired.vim ([q ]q [Q ]Q)
:Glog -10   //last 10
:Glog -10 --reverse
:Glog -1 --until=yesterday
:Glog --    //commits, then you can browse the objects
```

*Gitv*
Same as doing it via fugitive, but easier to view

- Gitv  (Glog --)           // browser mode
- Gitv! (Glog)              // file mode
- <range>Gitv (<range>Glog) // file mode



