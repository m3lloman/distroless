# 01-demo-debian

Vulnerable Flask app on debian:12. Full OS, shell present, exploit works.

## Build and run

```bash
docker build -f Dockerfile -t 01-demo-debian ..
docker run -d --name 01-demo-debian -p 5001:5000 01-demo-debian
```

## Demo

```bash
./demo.sh
```

## Teardown

```bash
docker stop 01-demo-debian && docker rm 01-demo-debian
```
