```bash

# remove with extglob
#shopt -s extglob  # to enable extglob
#rm -v !("filename")
#rm -v !("filename1"|"filename2")
#rm -rf !("tags")
#cp !(b*) new_dir/
#shopt -u extglob  # disable


# copy with grep
#cp -R $(ls | grep -v '^subdir$') subdir/
#ls | grep -v file.txt | xargs rm

```
