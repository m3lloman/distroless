#!/usr/bin/env bash
# Run from inside the 07-demo-scratch/ folder.
# Build: docker build -f Dockerfile -t 07-demo-scratch ..
# Run:   docker run -d --name 07-demo-scratch -p 5007:5000 07-demo-scratch

set -euo pipefail

TARGET="http://localhost:5007"
sep() { echo; echo "─────────────────────────────────────────────"; }

sep
echo "STEP 1: Homepage -- Flask is running, pure Python, no subprocess"
curl -s "$TARGET/"

sep
echo "STEP 2: Normal ping -- fails with 500, subprocess(shell=True) needs /bin/sh"
curl -s -o /dev/null -w "HTTP status: %{http_code}\n" "$TARGET/ping?host=8.8.8.8"

sep
echo "STEP 3: Exploit attempt -- same 500, /bin/sh still missing"
echo "        Payload: ?host=8.8.8.8; id"
curl -s -o /dev/null -w "HTTP status: %{http_code}\n" "$TARGET/ping?host=8.8.8.8%3B+id"

sep
echo "STEP 4: Try to exec a shell into the container"
docker exec 07-demo-scratch /bin/sh 2>&1 || echo "  OCI error: /bin/sh not found"

sep
echo "STEP 5: Confirm /bin does not exist at all"
docker exec 07-demo-scratch ls /bin 2>&1 || echo "  ls not found -- nothing in /bin"

sep
echo "Key point: scratch removes /bin/sh entirely."
echo "subprocess(shell=True) fails before any user input is evaluated."
