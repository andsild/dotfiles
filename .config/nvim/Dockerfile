FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    gnupg2 \
    ca-certificates \
    lsb-release \
    python3-neovim \
    fd-find \
    ripgrep \
    silversearcher-ag \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:neovim-ppa/stable && \
    apt-get update && \
    apt-get install -y neovim && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarnkey.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn && \
    rm -rf /var/lib/apt/lists/*

ENV PYTHONUNBUFFERED=1

RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

RUN mkdir -p ~/.config/nvim ~/.local ~/.cache ~/code

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all && ln -s /root/.fzf/bin/fzf /usr/bin/fzf

COPY . /root/.config/nvim/

RUN nvim -c ":PlugInstall! | qa" && nvim -c ":UpdateRemotePlugins | qa"
RUN mkdir -p ~/.config/coc/extensions && \
  cd ~/.config/coc/extensions && \
  echo '{"dependencies":{}}'> package.json && \
  npm install coc-snippets coc-pyright coc-json --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod 

RUN mkdir -p /opt/conda_env
ENV PATH /opt/conda_env/bin:$PATH

WORKDIR /code
SHELL ["/bin/bash", "-c"]
ENV SHELL=/bin/bash
CMD ["/usr/bin/env", "bash", "-c", "nvim"]
