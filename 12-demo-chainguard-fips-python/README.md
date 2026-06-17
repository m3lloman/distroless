# 12-demo-chainguard-fips-python

Same vulnerable Flask app on Chainguard FIPS Python 3.13 (Wolfi, FIPS-validated crypto).
No shell -- subprocess(shell=True) fails with HTTP 500. uid=65532 (nonroot).

## Build and run

```bash
docker build -f Dockerfile -t 12-demo-chainguard-fips-python .
docker run -d --name 12-demo-chainguard-fips-python -p 5012:5000 12-demo-chainguard-fips-python
```

## Key behaviors

| Action | Result |
|---|---|
| `/ping?host=8.8.8.8` | 500 -- subprocess(shell=True) needs /bin/sh |
| `/ping?host=8.8.8.8; id` | 500 -- exploit never runs |
| `docker exec 12-demo-chainguard-fips-python /bin/sh` | OCI error -- /bin/sh does not exist |

## Teardown

```bash
docker stop 12-demo-chainguard-fips-python && docker rm 12-demo-chainguard-fips-python
```
