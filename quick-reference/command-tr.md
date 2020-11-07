The tr command in UNIX is a command line utility for translating or deleting
characters. It supports a range of transformations including uppercase to
lowercase, squeezing repeating characters, deleting specific characters and
basic find and replace

```bash
$ tr [OPTION] SET1 [SET2]
cat file | tr “[a-z]” “[A-Z]”
cat file | tr “[:lower:]” “[:upper:]”  # same
cat file | | tr [:space:] '\t'

tr '{}' '()'   newfile.txt

# squeeze
echo "Welcome    To    GeeksforGeeks" | tr -s [:space:] ' '

# delete
echo "Welcome To GeeksforGeeks" | tr -d 'w'
echo "my ID is 73535" | tr -d [:digit:]

# complement (opposite)
echo "my ID is 73535" | tr -cd [:digit:]
```

note: tr works on characters (changes or deletes them). sed works on lines
(modifies words or other parts of lines, or inserts or deletes lines). awk work
on records with fields (by default whitespace separated fields on a line, but
this may be changed by setting FS and RS ).

