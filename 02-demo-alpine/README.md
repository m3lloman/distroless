# 02-demo-alpine

Vulnerable Flask app on alpine:3.20. Shell present, exploit works.

## Build and run

```bash
docker build -f Dockerfile -t 02-demo-alpine ..
docker run -d --name 02-demo-alpine -p 5002:5000 02-demo-alpine
```

## Teardown

```bash
docker stop 02-demo-alpine && docker rm 02-demo-alpine
```
