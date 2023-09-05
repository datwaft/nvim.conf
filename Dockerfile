FROM ubuntu

# Install dependencies
RUN apt-get update -y && apt-get install -y \
  build-essential \
  cargo \
  cmake \
  curl \
  gettext \
  git \
  ninja-build \
  nodejs \
  npm \
  python3 \
  unzip \
  wget

# Install neovim
RUN git clone https://github.com/neovim/neovim /tmp/neovim
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

# Install plugins
RUN nvim --headless "+Lazy! sync" +qa

# Finish
WORKDIR /root/.config/nvim
