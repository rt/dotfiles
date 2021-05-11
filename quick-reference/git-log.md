# git-log

*Previous Revisions*

What recent commit might have done ...?

```
:Gclog       //load all previous revisions of the current file into the quickfix list (:cprev :cnext :cfirst :clast)  unimpaired.vim ([q ]q [Q ]Q)
:Gclog -10   //last 10
:Gclog -10 --reverse
:Gclog -1 --until=yesterday
```

*Commits that touched current file*

File isn't right, what commits changed this recently?

```
:Gclog -- %  
:Gclog -10 -- % 
```

*Commit messages*

Search for id, your name

- `:Gclog --grep=something --`
- `:Gclog --grep=something -- %`

*Pickaxe*

What introduced this keyword?

- `:Gclog -10 -SfindMe --` : Find when something was introduced/changed
- `:Gclog -SfindMe -- %` : Find when something was introduced/changed for current file
