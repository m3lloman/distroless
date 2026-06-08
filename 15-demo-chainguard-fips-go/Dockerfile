# Build from this folder: docker build -f Dockerfile -t 15-demo-chainguard-fips-go .
# Builder: FIPS Go 1.26 dev  Runtime: glibc-openssl-fips (no shell, FIPS OpenSSL).
# IMPORTANT: Read the image overview before using this image in production.
# https://images.chainguard.dev/directory/image/go-fips/overview

FROM cgr.dev/chainguard/go-fips:1.26-dev AS builder

WORKDIR /app
COPY go.mod main.go ./
RUN CGO_ENABLED=1 GOOS=linux \
    go build -ldflags="-s -w" -o ping-app .

FROM cgr.dev/chainguard/glibc-openssl-fips:15

COPY --from=builder /app/ping-app /ping-app

EXPOSE 5000

USER 65532
ENTRYPOINT ["/ping-app"]
