# 14-demo-chainguard-fips-node

Same command injection vulnerability in Node/Express. Chainguard FIPS Node 24 slim
runtime. No shell (unlike non-FIPS node:latest which includes busybox).
exec() returns ENOENT. uid=65532 (nonroot).

## Build and run

```bash
docker build -f Dockerfile -t 14-demo-chainguard-fips-node .
docker run -d --name 14-demo-chainguard-fips-node -p 5014:5000 14-demo-chainguard-fips-node
```

## Key behaviors

| Action | Result |
|---|---|
| `/ping?host=8.8.8.8` | JSON with error -- exec() returns ENOENT |
| `/ping?host=8.8.8.8; id` | Same error -- exploit never executes |
| `docker exec 14-demo-chainguard-fips-node /bin/sh` | OCI error -- /bin/sh does not exist |

## Teardown

```bash
docker stop 14-demo-chainguard-fips-node && docker rm 14-demo-chainguard-fips-node
```
