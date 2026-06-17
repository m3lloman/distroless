# 08-demo-chainguard-python

Same vulnerable Flask app, running on cgr.dev/chainguard/python (Wolfi-based).
No shell -- subprocess(shell=True) fails with HTTP 500. uid=65532 (nonroot).

## Build and run

```bash
docker build -f Dockerfile -t 08-demo-chainguard-python .
docker run -d --name 08-demo-chainguard-python -p 5008:5000 08-demo-chainguard-python
```

## Key behaviors

| Action | Result |
|---|---|
| `/ping?host=8.8.8.8` | 500 -- subprocess(shell=True) needs /bin/sh |
| `/ping?host=8.8.8.8; id` | 500 -- exploit never runs |
| `docker exec 08-demo-chainguard-python /bin/sh` | OCI error -- /bin/sh does not exist |

## Teardown

```bash
docker stop 08-demo-chainguard-python && docker rm 08-demo-chainguard-python
```
