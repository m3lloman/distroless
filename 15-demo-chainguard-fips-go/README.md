# 15-demo-chainguard-fips-go

Same command injection vulnerability in Go. Builder uses Chainguard FIPS Go 1.26
(systemcrypto + requirefips tags). Runtime is glibc-openssl-fips.
No shell. exec.Command("/bin/sh") returns ENOENT. uid=65532 (nonroot).

## Build and run

```bash
docker build -f Dockerfile -t 15-demo-chainguard-fips-go .
docker run -d --name 15-demo-chainguard-fips-go -p 5015:5000 15-demo-chainguard-fips-go
```

## Teardown

```bash
docker stop 15-demo-chainguard-fips-go && docker rm 15-demo-chainguard-fips-go
```
