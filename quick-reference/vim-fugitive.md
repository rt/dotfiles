### fugitive

```text
% is the path of the current file 
:Git add %         	,or :Gwrite
:Git checkout %		,or :Gread
:Git rm %			,or :Gremove (also handles .swp)
:Git mv %			,or :Gmove   (also handles .swp)  :Gmove dest     :Gmove /repoTop/xx
:Gcommit (good because you get autocomplete)
:Gblame  (line by line of who was responsible) press P or ~ and reblame too!, press o to open the commit
:Gedit :0 to get index version or current file or :path/to/file for a different file  (Git add will make them the same)
typically from Gdiff you Gwrite to add, or Gread to revert
use diffget(do)/diffput(dp) to patch parts of the working copy to the index (git diff --cached) will show the difference
sometimes vim gets confused in the diff highlighting, diffupdate will redraw
```
							

