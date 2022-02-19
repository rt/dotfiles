# Basic workflow

```
# create
git checkout -b newstory
git push -u origin newstory

# water
git merge origin/master 
git push

# on upstream
git pull
git merge --squash --no-commit story
git commit -m "new squashed commit"  
git push

# delete
git push origin :story 
git branch -d story
```

**Working files**

Do work and want to look at what's in the commit

- :Git difftool               // quickfix list of edited working files (stages and unstaged don't come up)
- ]q                          // next
- :Gvdiffsplit                // if you want the diff view
- :GitGutterUndoHunk          // similar to piecemeal (piecemeal allows you to see what is in staged and working)
- :Git                        // stage what you want, diff if curious, and commit
- :Git push


**Merge branch into master**

git merge --no-commit --squash feature

All files are staged (you can unstage but if you have other unstaged files ... probably should try to stay clean)

- :Git                        // Unstage
- Do working files workflow
