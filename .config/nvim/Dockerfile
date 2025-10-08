FROM ubuntu:24.04
# docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg USERNAME=$USER . -t pesktux/nvim:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bc \
    build-essential \
    ca-certificates \
    curl \
    fd-find \
    file \
    fzf \
    gcc \
    gnupg2 \
    git \
    jq \
    less \
    lsb-release \
    neovim \
    ncdu \
    ripgrep \
    python3-dev \
    python3-pip \
    python3-neovim \
    silversearcher-ag \
    software-properties-common \
    wget \
    yq \
    # && add-apt-repository -y ppa:neovim-ppa/stable \
    # && apt update \
    # && apt-install -y neovim \ 
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
  && (rm -rf /opt/nvim || true) && tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# apt's yq is often outdated
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarnkey.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn && \
    rm -rf /var/lib/apt/lists/*

ENV NVM_DIR /usr/local/nvm

RUN mkdir -p "$NVM_DIR"; \
    curl -o- \
        "https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh" | \
        bash \
    ; \
    . $NVM_DIR/nvm.sh; \
    nvm install --lts --latest-npm

ENV PYTHONUNBUFFERED=1

ARG UID
ARG GID
ARG USERNAME
RUN userdel ubuntu && addgroup --gid $GID $USERNAME && adduser --uid $UID --ingroup $USERNAME $USERNAME
USER $USERNAME
WORKDIR /home/$USERNAME

RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' && \
  git clone https://github.com/andsild/dotfiles.git && \
  ln -s ~/dotfiles/.inputrc ~/dotfiles/.gitconfig ~/dotfiles/.ipython ~/ && \
  rm -r ~/.bashrc && ln -s ~/dotfiles/.bashrc ~/ && \
  mkdir -p ~/.config/ ~/.local/bin ~/.cache ~/code && \
  ln -s ~/dotfiles/.config/nvim/ ~/.config && nvim --headless -n +'PlugInstall --sync' +qa

RUN echo ". /usr/local/nvm/nvm.sh && (command -v node >/dev/null || nvm install node) && nvm use node" >> ~/.bashrc \
  && echo "export SHELL=/bin/bash" >> ~/.bashrc \
  && . /usr/local/nvm/nvm.sh && nvm install --lts

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all && ln -s /home/$USERNAME/.fzf/bin/fzf ~/.local/bin/fzf

RUN nvim -c ":PlugInstall! | qa" && nvim -c ":UpdateRemotePlugins | qa"
RUN mkdir -p ~/.config/coc/extensions && \
  cd ~/.config/coc/extensions && \
  echo '{"dependencies":{}}'> package.json && \
  npm install coc-snippets coc-pyright coc-json --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod 

WORKDIR /code
SHELL ["/bin/bash", "-c"]
ENV SHELL=/bin/bash
CMD ["/usr/bin/env", "bash", "-c", "PATH=~/.local/bin:$PATH;nvim"]
