FROM ubuntu

# Install dependencies
RUN apt-get update -y && \
  apt-get install -y git golang ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen

# Install neovim
WORKDIR /tmp
RUN git clone https://github.com/neovim/neovim
WORKDIR /tmp/neovim
RUN make CMAKE_BUILD_TYPE=Release
RUN make install

# Clone essential plugins
WORKDIR /root/.local/share/nvim/lazy
RUN git clone --filter=blob:none --single-branch https://github.com/folke/lazy.nvim.git
RUN git clone --filter=blob:none --single-branch https://github.com/rktjmp/hotpot.nvim.git
RUN git clone --filter=blob:none --single-branch https://github.com/datwaft/themis.nvim.git

# Deploy configuration
COPY . /root/.config/nvim

# Finish
WORKDIR /root/.config/nvim
