#!/bin/bash

USERNAME=${USERNAME-auto}

# Determine the appropriate non-root user
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    USERNAME=""
    POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
    for CURRENT_USER in ${POSSIBLE_USERS[@]}; do
        if id -u ${CURRENT_USER} > /dev/null 2>&1; then
            USERNAME=${CURRENT_USER}
            break
        fi
    done
    if [ "${USERNAME}" = "" ]; then
        USERNAME=root
    fi
elif [ "${USERNAME}" = "none" ] || ! id -u ${USERNAME} > /dev/null 2>&1; then
    USERNAME=root
fi


sh -c "$(curl -fsSL https://starship.rs/install.sh)" "" -y

printf 'ZSH_THEME="amuse"\nENABLE_CORRECTION="false"\nplugins=(docker git virtualenv brew zsh-autosuggestions command-not-found zsh-syntax-highlighting)\nsource $ZSH/oh-my-zsh.sh\neval "$(starship init zsh)"\nexport NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' > "/home/$USERNAME/.zshrc"

echo "exec `which zsh`" > "/home/$USERNAME/.bashrc"
