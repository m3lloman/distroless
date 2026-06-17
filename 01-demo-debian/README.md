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

## Key behaviors

| Action | Result |
|---|---|
| `/ping?host=8.8.8.8` | JSON ping response |
| `/ping?host=8.8.8.8; id` | Command injection works, returns uid output |
| `docker exec 01-demo-debian /bin/sh` | Shell access granted |

## Teardown

```bash
docker stop 01-demo-debian && docker rm 01-demo-debian
```
