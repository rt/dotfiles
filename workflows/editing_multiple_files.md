# Editing Multiple Files

## Find multiple files by searching content (and can replace)

- `Ag` or other above: Simple but you can't work with the subset, unless you want to use buffers as the list container

- `args ...` > `vimgrep /patt/g ##`: Put scope files in args then get subset with vimgrep to quickfix list
    or,
- `Ggrep ...` 

*replace*
- `vimgrep /patt/g ##`         : test search pattern against args
- `cdo %s/patt/replacement/ge` : do replacement against the quickfix list
- `cdo update`                 : update only changes files

- `cdo g/patt/d`                : delete lines containing
-
- `cdo g/patt/-1d`              : supply a range (delete the line preceeding the pattern)




## run a : command on every file in the argument list:

```
:argdo StripWhitespace
:bufdo call StripWhitespace()
:cdo StripWhitespace
```

Or to run macro q on every file in the arguments list:
```
:argdo normal @q
```

You can then save all changed buffers with :wa

If you want to write the files as you go along, you can add in a call to :update, like so:

```
:argdo s/foo/bar/ge | update
```


```bash
argdo bd
```

