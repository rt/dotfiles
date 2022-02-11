SED command in UNIX is stands for stream editor and it can perform lot’s of
function on file like, searching, find and replace, insertion or deletion.
Though most common use of SED command in UNIX is for substitution or for find
and replace. By using SED you can edit files even without opening it, which is
much quicker way to find and replace something in file, than first opening that
file in VI Editor and then changing it.
- SED is a powerful text stream editor. Can do insertion, deletion, search and replace(substitution).
- SED command in unix supports regular expression which allows it perform complex pattern matching.


```bash
sed OPTIONS... [SCRIPT] [INPUTFILE...]

sed 's/unix/linux/' geekfile.txt
sed 's/unix/linux/g' geekfile.txt
sed 's/unix/linux/2' geekfile.txt # select the occurance
sed 's/unix/linux/3g' geekfile.txt  # occurance and all
sed '3 s/unix/linux/' geekfile.txt  # on specified line
sed '1,3 s/unix/linux/' geekfile.txt  # on range
sed '2,$ s/unix/linux/' geekfile.txt

# print 
sed 's/unix/linux/p' geekfile.txt
sed -n 's/unix/linux/p' geekfile.txt  # print only replaced lines to console

echo "Welcome To The Geek Stuff" | sed 's/\(\b[A-Z]\)/\(\1\)/g' # Add paraenthese around first letter of each word

# delete
sed '5d' filename.txt # particular line
sed '$d' filename.txt
sed '3,6d' filename.txt
sed '12,$d' filename.txt
sed '/abc/d' filename.txt

sed -i 's/\\n/\n/g' input_filename
cat file1 file2 file3 file4 | sed 's/\\n/\n/g' > output_file
```

note: tr works on characters (changes or deletes them). sed works on lines
(modifies words or other parts of lines, or inserts or deletes lines). awk work
on records with fields (by default whitespace separated fields on a line, but
this may be changed by setting FS and RS ).


