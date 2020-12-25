FROM elixir:1.11.2-alpine

WORKDIR /opt/blockchain

COPY blockchain_service .

EXPOSE 4001

CMD ./blockchain_service