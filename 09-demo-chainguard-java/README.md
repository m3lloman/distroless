# 09-demo-chainguard-java

Same command injection vulnerability in plain Java HTTP server.
Runtime: cgr.dev/chainguard/jre (no shell). uid=65532 (nonroot).
Runtime.exec("/bin/sh") fails: No such file or directory.

## Build and run

```bash
docker build -f Dockerfile -t 09-demo-chainguard-java .
docker run -d --name 09-demo-chainguard-java -p 5009:5000 09-demo-chainguard-java
```

## Teardown

```bash
docker stop 09-demo-chainguard-java && docker rm 09-demo-chainguard-java
```
