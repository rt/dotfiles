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


```bash
:%s/\n/\r/g # same as,  sed -i 's/\\n/\n/g' input_filename
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

