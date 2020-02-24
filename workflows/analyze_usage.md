# Analyze Usage

Find a file by seaching content

## Tools

*Ag/Rg*
Rg might be a little faster but no(?) preview window on vim

*Ggrep*
Search only git files.  Will put in quickfix, and you can search any branch.

## Scope
	
- `Ag`                     : Simple but need to sift
- `lcd` > `Ag`             : Limit the scope but still flexible to go to any directory, or easy to do cwd
- `custon_query.sh` > `ag` : Limit to subset of project-wide query

## Examples

*Search for automation tags*
- cd test-automation
- ag <cfile>

*Search usages of current file (hbs)*
- cd scope
- get_usages_by_current_file

*Seach other usages under cursor*
- cd scope
- ag <cfile>

*Search usages on different branch (quick look)*
Kinda rare, usually pull branch into a different directory for analysis
- :Ggrep findMe master

    
    
    
    
    
In nerdtree, we need to change directories, get nerdtree in the main pane, and move to the main pain.
Then, do search.
```
'cd' + 'go' + Ctl-right + ',f'
```
