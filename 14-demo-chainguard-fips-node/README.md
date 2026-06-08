# 14-demo-chainguard-fips-node

Same command injection vulnerability in Node/Express. Chainguard FIPS Node 24 slim
runtime. No shell (unlike non-FIPS node:latest which includes busybox).
exec() returns ENOENT. uid=65532 (nonroot).

## Build and run

```bash
docker build -f Dockerfile -t 14-demo-chainguard-fips-node .
docker run -d --name 14-demo-chainguard-fips-node -p 5014:5000 14-demo-chainguard-fips-node
```

## Teardown

```bash
docker stop 14-demo-chainguard-fips-node && docker rm 14-demo-chainguard-fips-node
```
