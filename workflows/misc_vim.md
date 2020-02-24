## misc

```text
[{  beg code block
]}  end code block
[(  beg paren
])  end paren
```


### autocomplete insert mode

```text
Ctrl-p/n
Ctrl-x 
  Ctrl-l (line), Ctrl-f (filename)
```

*tweak your queries*
`q:` will allow you to edit previous commands, instead of having to write them out again


### fugitive

```text
% is the path of the current file 
:Git add %         	,or :Gwrite
:Git checkout %		,or :Gread
:Git rm %			,or :Gremove (also handles .swp)
:Git mv %			,or :Gmove   (also handles .swp)  :Gmove dest     :Gmove /repoTop/xx
:Gcommit (good because you get autocomplete)
:Gblame  (line by line of who was responsible) press P or ~ and reblame too!, press o to open the commit
:Gstatus (use ctrl-n ctrl-p to move file to file and jump to, push - to stage or unstage files)
:Gdiff   (to code review the changes)
:Gedit :0 to get index version or current file or :path/to/file for a different file  (Git add will make them the same)
typically from Gdiff you Gwrite to add, or Gread to revert
use diffget(do)/diffput(dp) to patch parts of the working copy to the index (git diff --cached) will show the difference
sometimes vim gets confused in the diff highlighting, diffupdate will redraw
```
							
### ultisnips

The sniplets are in the dotfiles project, executed per filetype.
To use visually highlighted text in ultisnips, visually select then press <TAB> then type the trigger word.
You can then do more complicated things than surround.
Also, see use with the python interpreter http://vimcasts.org/episodes/ultisnips-python-interpolation/


