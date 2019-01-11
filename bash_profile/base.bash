
export PATH="$HOME/bin:$PATH";
export PATH="$HOME/bin/work:$PATH";

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




### Terminal Syntax Highlighting

# Setup: "brew install highlight"

# Pipe Highlight to less
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style solarized-light"
export LESS=" -R"
alias less='less -m -N -g -i -J --line-numbers --underline-special'
alias more='less'

# Use "highlight" in place of "cat"
alias cat="highlight $1 --out-format xterm256 --line-numbers --quiet --force --style solarized-light"

# Setup JSON Syntax Highlighting
# Copy js.lang to json.lang with the following command
# cp "$(dirname $(brew list highlight | head -n 1))/share/highlight/langDefs/js.lang" "$(dirname $(brew list highlight | head -n 1))/share/highlight/langDefs/json.lang"




alias sp='source ~/.bash_profile'
alias bp='less ~/.bash_profile'
alias xf='less ~/.extafile'
alias kk='less ~/projects/qmk_firmware/users/ryan/ryan.h'
alias cb='chrome_bookmarks'
alias vv='less ~/projects/work/vim.md'
alias bb='less ~/projects/work/bash.md'
alias gg='less ~/projects/work/git.md'
alias tt='less ~/projects/work/tmux.md'
alias ii='less ~/projects/work/idea.md'
alias dd='less ~/projects/work/docker.md'
alias vrc='less ~/.vimrc'
