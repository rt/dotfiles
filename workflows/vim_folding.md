### vim xml folding

//.vimrc

	let g:xml_syntax_folding=1
	au FileType xml setlocal foldmethod=syntax

//folding commands

	zf#j creates a fold from the cursor down # lines.
	zf/string creates a fold from the cursor to string .
	zj moves the cursor to the next fold.
	zk moves the cursor to the previous fold.
	zo opens a fold at the cursor.
	zc closes a fold at the cursor.
	zO opens all folds at the cursor.
	zm increases the foldlevel by one.
	zM closes all open folds.
	zr decreases the foldlevel by one.
	zR decreases the foldlevel to zero -- all folds will be open.
	zd deletes the fold at the cursor.
	zE deletes all folds.
	[z move to start of open fold.
	]z move to end of open fold.
	

