#!/usr/bin/env bash
# Run from inside the 05-demo-ubi-minimal/ folder.
# Build: docker build -f Dockerfile -t 05-demo-ubi-minimal ..
# Run:   docker run -d --name 05-demo-ubi-minimal -p 5005:5000 05-demo-ubi-minimal

set -euo pipefail

TARGET="http://localhost:5005"
sep() { echo; echo "─────────────────────────────────────────────"; }

sep
echo "STEP 1: Package count"
docker exec 05-demo-ubi-minimal rpm -qa | wc -l

sep
echo "STEP 2: Normal ping"
curl -s "$TARGET/ping?host=8.8.8.8" | python3 -m json.tool

sep
echo "STEP 3: Exploit -- command injection"
echo "        Payload: ?host=8.8.8.8; id"
curl -s "$TARGET/ping?host=8.8.8.8%3B+id" | python3 -m json.tool

sep
echo "STEP 4: Shell present"
docker exec 05-demo-ubi-minimal ls -la /bin/sh

sep
echo "STEP 5: Drop into a shell"
docker exec -it 05-demo-ubi-minimal /bin/bash
