
# setup autocomplete in bash into the current shell, bash-completion package should be installed first.
# source <(kubectl completion bash) 

# add autocomplete permanently to your bash shell.
# echo "source <(kubectl completion bash)" >> ~/.bashrc 

# alias and allow completion to work with it
# alias k=kubectl
# complete -F __start_kubectl k


# zsh
# source <(kubectl completion zsh)  # setup autocomplete in zsh into the current shell
# echo "if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi" >> ~/.zshrc # add autocomplete permanently to your zsh shell
