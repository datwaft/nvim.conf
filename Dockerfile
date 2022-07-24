FROM ubuntu
FROM python:3
FROM gcc
FROM rust

# Install dependencies
RUN apt-get update -y && \
  apt-get install -y git golang ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen

# Install neovim
WORKDIR /tmp
RUN git clone https://github.com/neovim/neovim
WORKDIR /tmp/neovim
RUN make CMAKE_BUILD_TYPE=Release
RUN make install

# Install essential neovim plugins
WORKDIR /root/.local/share/nvim/site/pack/packer/start
RUN git clone https://github.com/wbthomason/packer.nvim
RUN git clone https://github.com/rktjmp/hotpot.nvim --branch nightly
RUN git clone https://github.com/Olical/conjure
RUN git clone https://github.com/datwaft/themis.nvim

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
