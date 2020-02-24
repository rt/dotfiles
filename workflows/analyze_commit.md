### Analyze a Commit

If you want to check out someone's branch, etc.

## Full Analysis

Might do this on ~/dev/repos/dev1

```bash
git fetch
git checkout master
git merge feature-branch --no-commit --squash
vim
:Gstatus
:Gmerge
```


## Quick Analysis

```bash
:Gedit sha   (equal to "git show sha")
:Gedit branch/tag
```

## From blame

Transvering the git object tree is not efficient except sometimes you might find yourself poking in

- `Gblame`
- `o` : Display in split the commit you are interested in
- `- or ~` : Or, reblame for file in question (equivalent to opening a file in the commit but with the new blame)
- `edit %:h` : Go to parent when doing tree tranversal (I don't see when this is useful) 
- `C` : Get to commit object


