# Find old file that was deleted

	#find commit where file was deleted
	git rev-list -n 1 HEAD -- Source/deleted-git-file.txt

	#checkout that commit as new file in working tree
	git checkout 6d8e24d4236627a35f56f32947ae5593fc917880^ -- Source/deleted-git-file.txt


