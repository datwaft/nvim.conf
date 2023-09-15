FROM ubuntu AS build
# Install dependencies
RUN apt-get update -y && apt-get install -y \
  cmake \
  curl \
  file \
  gettext \
  git \
  ninja-build \
  unzip
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
  git
# Install neovim
COPY --from=build /tmp/neovim/build/nvim*.deb /tmp/nvim.deb
RUN dpkg -i /tmp/nvim.deb
# Clone essential plugins
WORKDIR /root/.local/share/nvim/lazy
RUN git clone https://github.com/catppuccin/nvim catppuccin
RUN git clone https://github.com/folke/lazy.nvim
RUN git clone https://github.com/rktjmp/hotpot.nvim
RUN git clone https://github.com/datwaft/themis.nvim.git
# Deploy configuration
COPY . /root/.config/nvim/
# Install plugins
RUN nvim --headless "+Lazy! sync" +qa
# Finish
WORKDIR /root/.config/nvim
CMD ["nvim"]
