## misc

```
:[range]g/pattern/cmd
:g/^\s*$/d
:g/^$/d
:g/this\|that/d
:g!/this\|that/d
:v/this\|that/d
```

similar to sed (this is good if you are working with files)
```
sed -i '/green/d' colors   #dry run
sed -i.bak '/green\|violet/d' colors
sed '/green/d' colors
sed '/green/!d' colors
sed '/green\|violet/d' colors
```

```text
[{  beg code block
]}  end code block
[(  beg paren
])  end paren
```


### autocomplete insert mode

```text
Ctrl-p/n
Ctrl-x 
  Ctrl-l (line), Ctrl-f (filename)
```

*tweak your queries*
`q:` will allow you to edit previous commands, instead of having to write them out again


### ultisnips

The sniplets are in the dotfiles project, executed per filetype.
To use visually highlighted text in ultisnips, visually select then press <TAB> then type the trigger word.
You can then do more complicated things than surround.
Also, see use with the python interpreter http://vimcasts.org/episodes/ultisnips-python-interpolation/


