### Diff two files

**Terminal**

Side by side
```
vimdiff file1 file2
```

Create a patch
```
diff file1 file2
```

**Vim**

first get two files in two windows (:vsp)

:windo diffthis

- `do`: get changes from other window
- `dp`: put changes from this window
- `]c`: next change
- `[c`: prev change
- `diffupdate`

:vimoff

or, toggle with `=od`


