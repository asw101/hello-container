FROM elixir:latest

# RUN apt-get update && apt-get install -y net-tools

WORKDIR /app
COPY . .
RUN mix local.hex --force && mix deps.get && mix local.rebar --force
RUN mix compile

CMD ["iex", "-S", "mix"]
