# Build from this folder: docker build -f Dockerfile -t 14-demo-chainguard-fips-node .
# Builder: FIPS Node 24 dev (has npm)  Runtime: FIPS Node 24 slim (no shell).
# IMPORTANT: Read the image overview before using this image in production.
# https://images.chainguard.dev/directory/image/node-fips/overview

FROM cgr.dev/chainguard/node-fips:24-dev AS builder

WORKDIR /app
COPY package.json app.js ./
RUN npm install --omit=dev

FROM cgr.dev/chainguard/node-fips:24-slim

WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/app.js .

EXPOSE 5000

# Already runs as uid=65532 (nonroot)
ENTRYPOINT ["/usr/bin/node", "app.js"]
