# reset

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

