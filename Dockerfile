FROM ubuntu:latest
FROM gcc:latest
FROM rust:latest

ENV PATH /root/.local/bin:$PATH

# Install dependencies
RUN apt-get update && apt-get install -y curl git golang nodejs npm python3 python3-pip build-essential ninja-build sqlformat
RUN cargo install rnix-lsp taplo-lsp stylua
RUN pip3 install cmake-language-server black
RUN npm i -g bash-language-server pyright dockerfile-language-server-nodejs yaml-language-server vim-language-server typescript typescript-language-server emmet-ls vscode-langservers-extracted vls @fsouza/prettierd markdownlint-cli

# Install lua-language-server
WORKDIR /root/.local/bin
RUN git clone https://github.com/sumneko/lua-language-server
WORKDIR /root/.local/bin/lua-language-server
RUN git submodule update --init --recursive
RUN cd 3rd/luamake && ./compile/install.sh
RUN ./3rd/luamake/luamake rebuild
ENV PATH /root/.local/bin/lua-language-server/bin/Linux:$PATH

# Install rust-analyzer
WORKDIR /root/.local/bin
RUN curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > rust-analyzer
RUN chmod +x rust-analyzer

# Install clojure-lsp
WORKDIR /tmp
RUN curl -s https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install > clojure-lsp.sh
RUN chmod +x clojure-lsp.sh
RUN ./clojure-lsp.sh

# Install clangd
RUN apt-get update && apt-get install -y clangd-11
RUN update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-11 100

# Install Neovim
WORKDIR /tmp
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.6.0/nvim-linux64.tar.gz
RUN tar xzf nvim-linux64.tar.gz -C /opt
ENV PATH /opt/nvim-linux64/bin:$PATH

# Deploy the Neovim configuration
COPY . /root/.config/nvim

# Install plugins
WORKDIR /root/.local/share/nvim/site/pack/packer/start
RUN git clone https://github.com/rktjmp/hotpot.nvim
RUN git clone https://github.com/wbthomason/packer.nvim

# Finish
WORKDIR /root
