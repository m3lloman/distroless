# Build from this folder: docker build -f Dockerfile -t 10-demo-chainguard-node .
# Uses node:latest-dev to run npm install, runtime is node:latest (no shell).

FROM cgr.dev/chainguard/node:latest-dev AS builder

WORKDIR /app
COPY package.json app.js ./
RUN npm install --omit=dev

FROM cgr.dev/chainguard/node:latest

WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/app.js .

EXPOSE 5000

# Chainguard node image already runs as uid 65532 (nonroot)
ENTRYPOINT ["/usr/bin/node", "app.js"]
