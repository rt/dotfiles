
##### GIT

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
fi;

# bash completion for git
#source ~/bin/git-completion.bash
 

##### BASH
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;


##### FZF (this was done in .bashrc when you do the install, which does some completion)
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash



##### ANT
complete -C /usr/local/bin/complete-ant-cmd.pl ant
complete -C '/usr/local/bin/aws_completer' aws
 

##### SSH
# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;

