export PATH="$HOME/bin:$PATH";
export PATH="$HOME/bin/work:$PATH";
export PATH="$HOME/bin/vim:$PATH";

export NODE_PATH=/usr/lib/nodejs

# Make vim the default editor
export EDITOR="vim";

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X";

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Enable aliases to be sudo’ed
alias sudo='sudo '



alias sp='source ~/.bash_profile'
alias bp='less ~/.bash_profile'
alias kk='vim ~/projects/qmk_firmware/users/ryan/ryan.h'
alias cb='chrome_bookmarks'
alias vrc='less ~/.vimrc'
