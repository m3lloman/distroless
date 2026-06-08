# Build from this folder: docker build -f Dockerfile -t 11-demo-chainguard-go .
# Builder: cgr.dev/chainguard/go  Runtime: cgr.dev/chainguard/static (Wolfi-based, no shell).

FROM cgr.dev/chainguard/go:latest AS builder

WORKDIR /app
COPY go.mod main.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o ping-app .

FROM cgr.dev/chainguard/static:latest

COPY --from=builder /app/ping-app /ping-app

EXPOSE 5000

# Chainguard static image already runs as uid 65532 (nonroot)
ENTRYPOINT ["/ping-app"]
