FROM ubuntu
FROM python:3
FROM gcc
FROM rust

# Install dependencies
RUN apt-get update -y && \
apt-get install -y curl git golang

# Install neovim
WORKDIR /tmp
RUN curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
RUN tar xzf nvim-linux64.tar.gz -C /opt
ENV PATH /opt/nvim-linux64/bin:$PATH

# Install essential neovim plugins
WORKDIR /root/.local/share/nvim/site/pack/packer/start
RUN git clone https://github.com/wbthomason/packer.nvim
RUN git clone https://github.com/rktjmp/hotpot.nvim
RUN git clone https://github.com/Olical/conjure

# Install neovim plugins that need caching
# parinfer-rust
WORKDIR /root/.local/share/nvim/site/pack/packer/opt
RUN git clone https://github.com/eraserhd/parinfer-rust
WORKDIR /root/.local/share/nvim/site/pack/packer/opt/parinfer-rust
RUN cargo build --release
# vim-hexokinase
WORKDIR /root/.local/share/nvim/site/pack/packer/start
RUN git clone https://github.com/rrethy/vim-hexokinase
WORKDIR /root/.local/share/nvim/site/pack/packer/start/vim-hexokinase
RUN make hexokinase

# Deploy configuration
COPY . /root/.config/nvim

# Finish
WORKDIR /root/.config/nvim
