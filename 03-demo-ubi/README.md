# 03-demo-ubi

Vulnerable Flask app on ubi9/ubi:latest. Shell present, exploit works.

## Build and run

```bash
docker build -f Dockerfile -t 03-demo-ubi ..
docker run -d --name 03-demo-ubi -p 5003:5000 03-demo-ubi
```

## Teardown

```bash
docker stop 03-demo-ubi && docker rm 03-demo-ubi
```
