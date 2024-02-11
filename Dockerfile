FROM hexpm/elixir:1.16.1-erlang-26.2.2-debian-bookworm-20240130-slim AS builder

RUN apt-get update \
  && apt-get -y install make

WORKDIR /opt/app
COPY ./mix.exs ./
COPY ./mix.lock ./
RUN mix do local.hex --force, local.rebar --force \
  && mix do deps.get, deps.compile
