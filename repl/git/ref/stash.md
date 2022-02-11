# stashing

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


