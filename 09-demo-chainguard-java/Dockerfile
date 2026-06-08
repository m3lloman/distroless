# Build from this folder: docker build -f Dockerfile -t 09-demo-chainguard-java .
# Builder: cgr.dev/chainguard/jdk  Runtime: cgr.dev/chainguard/jre (no shell).

FROM cgr.dev/chainguard/jdk:latest AS builder

WORKDIR /app
COPY src/main/java/demo/PingServer.java ./
RUN mkdir -p classes && javac -d classes PingServer.java

FROM cgr.dev/chainguard/jre:latest

WORKDIR /app
COPY --from=builder /app/classes ./classes

EXPOSE 5000

# Chainguard jre image already runs as uid 65532 (nonroot)
ENTRYPOINT ["/usr/bin/java", "-cp", "classes", "demo.PingServer"]
