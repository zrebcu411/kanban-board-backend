FROM elixir:1.7-alpine

RUN mix local.hex --force && \
  mix local.rebar --force && \
  apk add --update make && \
  apk add build-base && \
  apk add bash


WORKDIR /usr/src/app
# ENTRYPOINT ["mix"]
# CMD ["phx.server"]
CMD mix do ecto.migrate, phx.server

COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile
COPY . ./
