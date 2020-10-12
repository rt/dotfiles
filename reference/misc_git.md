# git reference

## workflows

*use the commit message of the soft reset*
git commit -C HEAD@{1}

## Basic workflow

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

### log
    git --no-pager log --oneline --all --decorate --graph -40

    #pickaxe (commits that introduced or removed <string>
    git log -S<string>

### cherry picking

If fixes a bug for a previous release

	#for all above branches (newer) and master
	git checkout above-relases
	git cherry-pick {commit-hash}
	git push

### stashing

	git stash save "Some stash message"
	git stash list
	git stash show stash@{<revision>}
	#apply or pop
	git stash apply stash@{<revision>}
	git stash pop stash@{<revision>}
	#delete all stashes (carefull!)
	git stash clear
    #partial commit (-u stash untracked, -k keep staged files intact)
    git stash -u -k

### Staged changes

	#nuke your commit and go back 1, files and staging will be deleted
	git reset --hard HEAD~1

	#keep files and staging just undo the commit
	git reset --soft HEAD~1
    git commit -c ORIG_HEAD  //get back commit header/message

	#keep files
	git reset HEAD~1

	#remove from staging
	git reset filename

	#delete all untracked files
	git clean -f

	#list of partial commits, kept for 90 days in case you nuked commit
	git reflog

### Working tree change, revert to last committed

	#revert changed or deleted file
	git checkout file1

	#restore directory
	git checkout -- dir

### Rebase

	git rebase -i HEAD~4  //options come up

note: usually you will "pick" the one at the top and "squash" ones below on the commit edit
	

### Get remote branch

	git fetch origin  //now its in hand
	get checkout -b test origin/test

### Remote

    git remote show origin

    git remote set-url origin git://new.url.here
    git push -u origin master

### diff

	git diff HEAD file			//commit vs working tree
	git diff file						//index vs working tree
	git diff --cached file	//index vs commit 

### conflict resolution

	git mergetool				//bring up vimdiff
	//edit bottom buffer
	:diffget LOCAL				//use upper left (LOCAL) buffer (or use buffer number, find with :ls)
	:diffget REMOTE
	:w							//bottom file
	git commit
	
### patch

	//specify by sha (if only one is specified, HEAD is assumed)
	git diff from-commit to-commit > patch.diff

	//apply the patch

	//optional: look at changes first
	git apply --stat fix_empty_poster.patch

	//optional: test
	git apply --check fix_empty_poster.patch

	//note it just applies the total diff to the working tree (no commit logs, etc.)
	git apply patch.diff
	
another reason to always create a branch is you can make a patch and not worry about commits, just the branch (current) against master

	git format-patch master --stdout > fix_empty_poster.patch

	//using this allows you to sign off
	git am --signoff < fix_empty_poster.patch

### reflog

	git reflog 					//list up recent (even if you blew them away with git reset --hard HEAD~1)
	git reset --hard hash..
	
#### Find old file that was deleted

	#find commit where file was deleted
	git rev-list -n 1 HEAD -- Source/deleted-git-file.txt

	#checkout that commit as new file in working tree
	git checkout 6d8e24d4236627a35f56f32947ae5593fc917880^ -- Source/deleted-git-file.txt

### useful (git use .gitignore)
    ls-files *.js
