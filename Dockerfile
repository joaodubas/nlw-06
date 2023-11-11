FROM elixir:1.15.7-slim AS builder

RUN apt-get update \
  && apt-get -y install make

WORKDIR /opt/app
COPY ./mix.exs ./
COPY ./mix.lock ./
RUN mix do local.hex --force, local.rebar --force \
  && mix do deps.get, deps.compile
