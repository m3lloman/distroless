# 11-demo-chainguard-go

Same command injection vulnerability in Go. Runtime: cgr.dev/chainguard/static.
No shell -- exec.Command("/bin/sh") fails. uid=65532 (nonroot).

## Build and run

```bash
docker build -f Dockerfile -t 11-demo-chainguard-go .
docker run -d --name 11-demo-chainguard-go -p 5011:5000 11-demo-chainguard-go
```

## Key behaviors

| Action | Result |
|---|---|
| `/ping?host=8.8.8.8` | JSON with error -- exec.Command("/bin/sh") fails |
| `/ping?host=8.8.8.8; id` | Same error -- exploit never executes |
| `docker exec 11-demo-chainguard-go /bin/sh` | OCI error -- /bin/sh does not exist |

## Teardown

```bash
docker stop 11-demo-chainguard-go && docker rm 11-demo-chainguard-go
```
