# 11-demo-chainguard-go

Same command injection vulnerability in Go. Runtime: cgr.dev/chainguard/static.
No shell -- exec.Command("/bin/sh") fails. uid=65532 (nonroot).

## Build and run

```bash
docker build -f Dockerfile -t 11-demo-chainguard-go .
docker run -d --name 11-demo-chainguard-go -p 5011:5000 11-demo-chainguard-go
```

## Teardown

```bash
docker stop 11-demo-chainguard-go && docker rm 11-demo-chainguard-go
```
