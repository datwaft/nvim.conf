FROM ubuntu:latest
FROM gcc:latest
FROM rust:latest

# Install dependencies
RUN apt-get update && \
      apt-get install -y curl git golang

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
