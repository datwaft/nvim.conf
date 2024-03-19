FROM ubuntu AS build-nvim
# Install dependencies
RUN apt-get update -y && apt-get install -y \
  cmake \
  curl \
  file \
  gettext \
  git \
  ninja-build \
  unzip \
  && rm -rf /var/lib/apt/lists/*
# Build neovim
RUN git clone https://github.com/neovim/neovim /tmp/neovim
WORKDIR /tmp/neovim
RUN make CMAKE_BUILD_TYPE=Release
WORKDIR /tmp/neovim/build
RUN cpack -G DEB

FROM ubuntu AS run
# Install dependencies
RUN apt-get update -y && apt-get install -y \
  build-essential \
  fd-find \
  git \
  nodejs \
  npm \
  python3 \
  python3-pip \
  ripgrep \
  && rm -rf /var/lib/apt/lists/*
# Install neovim
COPY --from=build-nvim /tmp/neovim/build/nvim*.deb /tmp/nvim.deb
RUN dpkg -i /tmp/nvim.deb
# Clone essential plugins
WORKDIR /root/.local/share/nvim/lazy
RUN git clone https://github.com/folke/lazy.nvim
# Deploy configuration
COPY . /root/.config/nvim/
# Install plugins
RUN nvim --headless +"Lazy! sync" +qa
# Install tree-sitter parsers
RUN nvim --headless +"TSUpdateSync" +qa
# Finish
WORKDIR /root/.config/nvim
