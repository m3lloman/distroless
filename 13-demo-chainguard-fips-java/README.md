# 13-demo-chainguard-fips-java

Same command injection vulnerability in Java. Chainguard FIPS JRE 17 runtime
with BouncyCastle FIPS provider. No shell. uid=65532 (nonroot).
Runtime.exec("/bin/sh") returns: No such file or directory.

## Build and run

```bash
docker build -f Dockerfile -t 13-demo-chainguard-fips-java .
docker run -d --name 13-demo-chainguard-fips-java -p 5013:5000 13-demo-chainguard-fips-java
```

## Key behaviors

| Action | Result |
|---|---|
| `/ping?host=8.8.8.8` | 500 -- Runtime.exec("/bin/sh") returns No such file or directory |
| `/ping?host=8.8.8.8; id` | 500 -- exploit never runs |
| `docker exec 13-demo-chainguard-fips-java /bin/sh` | OCI error -- /bin/sh does not exist |

## Teardown

```bash
docker stop 13-demo-chainguard-fips-java && docker rm 13-demo-chainguard-fips-java
```
