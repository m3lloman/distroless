#!/usr/bin/env bash
# Run from inside the 06-demo-scratch-go/ folder.
# Build: docker build -f Dockerfile -t 06-demo-scratch-go .
# Run:   docker run -d --name 06-demo-scratch-go -p 5006:5000 06-demo-scratch-go

set -euo pipefail

TARGET="http://localhost:5006"
sep() { echo; echo "─────────────────────────────────────────────"; }

sep
echo "STEP 1: Normal ping -- returns error in JSON, /bin/sh missing"
curl -s "$TARGET/ping?host=8.8.8.8" | python3 -m json.tool

sep
echo "STEP 2: Exploit attempt"
echo "        Payload: ?host=8.8.8.8; id"
curl -s "$TARGET/ping?host=8.8.8.8%3B+id" | python3 -m json.tool

sep
echo "STEP 3: Try to exec a shell into the container"
docker exec 06-demo-scratch-go /bin/sh 2>&1 || echo "  /bin/sh not found"

sep
echo "STEP 4: Image size -- single static binary, nothing else"
docker images 06-demo-scratch-go --format "Size: {{.Size}}"
