FROM elixir:1.7-alpine

RUN mix local.hex --force

WORKDIR /usr/src/app
ENTRYPOINT ["mix"]
CMD ["phx.server"]

COPY mix.exs mix.lock ./
RUN mix deps.get
COPY . ./