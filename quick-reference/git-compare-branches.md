# git-compare-branches

### CLI

```bash
git diff master...feature
```

### Vim/Fugitive

**Quick Look**
```bash
:Gedit feature
```

**Full**
```bash
git checkout master
git merge --no-commit --squash feature
vim
:difftool
:mergetool
```

### IntelliJ
