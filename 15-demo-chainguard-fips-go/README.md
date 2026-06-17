# 15-demo-chainguard-fips-go

Same command injection vulnerability in Go. Builder uses Chainguard FIPS Go 1.26
(systemcrypto + requirefips tags). Runtime is glibc-openssl-fips.
No shell. exec.Command("/bin/sh") returns ENOENT. uid=65532 (nonroot).

## Build and run

```bash
docker build -f Dockerfile -t 15-demo-chainguard-fips-go .
docker run -d --name 15-demo-chainguard-fips-go -p 5015:5000 15-demo-chainguard-fips-go
```

## Key behaviors

| Action | Result |
|---|---|
| `/ping?host=8.8.8.8` | JSON with error -- exec.Command("/bin/sh") returns ENOENT |
| `/ping?host=8.8.8.8; id` | Same error -- exploit never executes |
| `docker exec 15-demo-chainguard-fips-go /bin/sh` | OCI error -- /bin/sh does not exist |

## Teardown

```bash
docker stop 15-demo-chainguard-fips-go && docker rm 15-demo-chainguard-fips-go
```
