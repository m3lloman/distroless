# 12-demo-chainguard-fips-python

Same vulnerable Flask app on Chainguard FIPS Python 3.13 (Wolfi, FIPS-validated crypto).
No shell -- subprocess(shell=True) fails with HTTP 500. uid=65532 (nonroot).

## Build and run

```bash
docker build -f Dockerfile -t 12-demo-chainguard-fips-python .
docker run -d --name 12-demo-chainguard-fips-python -p 5012:5000 12-demo-chainguard-fips-python
```

## Teardown

```bash
docker stop 12-demo-chainguard-fips-python && docker rm 12-demo-chainguard-fips-python
```
