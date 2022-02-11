# vim-ctags

create in the directory you will be working in.

*Work Java and others (es6 included)*
```
ctags -R -f .tags src/
ctags -R --language-force=java -f .tags core-webapp/src/ webapp-spring/src/ webcf/src/ web-common/src/ core/src/ common/src/
```

#### keys

    Ctrl-]      : go to definition (Ctrl-w Ctrl-] in a new window)
    Ctrl-t      : pop out of definition
    g]          : see definitions (when multiple)
    

*Work Js es5*
```
ctags_javascript dir
```

