# 06-demo-scratch-go

Same command injection vulnerability as 01-demo-debian, rewritten in Go.
CGO_ENABLED=0 static binary on FROM scratch. No shell, no libc, nothing.

exec.Command("/bin/sh", "-c", cmd) fails with "fork/exec /bin/sh: no such file".

## Build and run

```bash
# Context is local -- no ../app needed
docker build -f Dockerfile -t 06-demo-scratch-go .
docker run -d --name 06-demo-scratch-go -p 5006:5000 06-demo-scratch-go
```

## Demo

```bash
./demo.sh
```

## Key behaviors

| Action | Result |
|---|---|
| `/ping?host=8.8.8.8` | JSON with `error: fork/exec /bin/sh: no such file` |
| `/ping?host=8.8.8.8; id` | Same error -- exploit never executes |
| `docker exec 06-demo-scratch-go /bin/sh` | OCI error -- `/bin/sh` does not exist |
| Image size | ~7MB |

## Teardown

```bash
docker stop 06-demo-scratch-go && docker rm 06-demo-scratch-go
```
