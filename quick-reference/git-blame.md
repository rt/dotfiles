# git-blame


```
[04] :Git blame
o # open commit in hsplit to inpect if it is the commit that introduced something
:q
- # reblame if you need to dig further (wash and repeat)
gq # close and put you back on the working file
```

**from help**
                        A     resize to end of author column
                        C     resize to end of commit column
                        D     resize to end of date/time column
                        gq    close blame, then |:Gedit| to return to work
                              tree version
                        <CR>  close blame, and jump to patch that added line
                              (or directly to blob for boundary commit)
                        o     jump to patch or blob in horizontal split
                        O     jump to patch or blob in new tab
                        p     jump to patch or blob in preview window
                        -     reblame at commit
                        ~     reblame at [count]th first grandparent
                        P     reblame at [count]th parent (like HEAD^[count])

### IntelliJ

