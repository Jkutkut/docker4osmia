FROM jkutkut/docker4rust as builder

WORKDIR /app

COPY osmia-cli .

RUN cargo build --release

# Release image
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/target/release/osmia-cli ./osmia-cli
ENTRYPOINT ["./osmia-cli"]
