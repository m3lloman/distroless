# Build from this folder: docker build -f Dockerfile -t 06-demo-scratch-go .
# Static Go binary on scratch -- no shell, no libc, nothing.
# exec.Command("/bin/sh", "-c", cmd) fails with no such file or directory.
# CGO_ENABLED=0 produces a fully static binary with zero runtime dependencies.

FROM golang:1.22-alpine AS builder

WORKDIR /app
COPY go.mod main.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o ping-app . && \
    echo "appuser:x:10001:10001:appuser:/:/sbin/nologin" >> /etc/passwd && \
    echo "appuser:x:10001:" >> /etc/group

# ── Runtime stage ──────────────────────────────────────────────────────────
FROM scratch

COPY --from=builder /app/ping-app /ping-app
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group  /etc/group

USER 10001
EXPOSE 5000

ENTRYPOINT ["/ping-app"]
