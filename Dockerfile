FROM rust:latest AS base

USER root

ARG APP_DIR=/usr/app

RUN mkdir $APP_DIR
WORKDIR $APP_DIR

# Install Jupyter and evcxr

RUN apt update && apt install -y \
    jupyter-notebook \
    cmake
   
RUN cargo install evcxr_repl
RUN cargo install evcxr_jupyter

RUN evcxr_jupyter --install

# Configure Rust Channel

RUN rustup install nightly-2021-01-21
RUN rustup override set nightly-2021-01-21
RUN rustup default nightly-2021-01-21
RUN echo $(rustup show)

# Copy project directories

COPY src $APP_DIR/src
COPY Cargo.toml $APP_DIR/Cargo.toml
