FROM public.ecr.aws/w7v4c0m1/node:lts


ARG USERNAME=node
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN apt-get update \
    && apt-get install -y sudo zsh wget \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    # clean up
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

ENV ENV="/home/$USERNAME/.bashrc" \
    ZSH=/home/$USERNAME/.oh-my-zsh \
    EDITOR=vi \
    LANG=en_US.UTF-8

# install oh-my-zsh and plugins
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

COPY scripts/*.sh /tmp/library-scripts/
RUN /bin/bash /tmp/library-scripts/setup.sh

COPY bin/ /home/$USERNAME/bin/
# install aws-cli v2
RUN sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    sudo unzip awscliv2.zip && \
    sudo ./aws/install && \
    sudo rm -rf ./aws

# install nvm
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# install global dependent packages
RUN sudo npm i -g eslint typescript esbuild

WORKDIR /home/$USERNAME/app


