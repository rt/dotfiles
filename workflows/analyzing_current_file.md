# Analyzing Changes to File

*Previous Revisions*
This might not be that great because it's not a diff, just the full file.
```
:Glog       //load all previous revisions of the current file into the quickfix list (:cprev :cnext :cfirst :clast)  unimpaired.vim ([q ]q [Q ]Q)
:Glog -10   //last 10
:Glog -10 --reverse
:Glog -1 --until=yesterday
```
*Commits that touched current file*
You still need to dig to see the diff
```
:Glog -- %  
:Glog -10 -- % 
```

*Gitv*
Easier to view commits, `D` will give the diff
```
:Gitv! (Glog)              // file mode
:<range>Gitv (<range>Glog) // file mode
```

You will want to see the diff or reference (to copy)  with index/master
- `Gdiff` : With index
- `Gdiff master:%` : With master
- `Gedit` : Reference with index (toggles working/index files)
- `Gedit master:%` : Reference master
- `Gvsplit master:%` : Reference master in split
- `Gundo` : Reference local changes

- `vsp`
- Gedit branchname:%
- windo diffthis

- `Glog -SfindMe --` : Find when something was introduced/changed
- `Glog -SfindMe -- %` : Find when something was introduced/changed for current file

	press enter to drill in  (for trees you can toggle more info with "a")
	:edit %:h   to drill out  (mapped to ..)
	:Gedit   will return you to the working copy
