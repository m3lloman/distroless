# 04-demo-debian-slim

Vulnerable Flask app on debian:12-slim. Shell present, exploit works.
slim strips docs and locales but not packages -- same package count as debian:12.

## Build and run

```bash
docker build -f Dockerfile -t 04-demo-debian-slim ..
docker run -d --name 04-demo-debian-slim -p 5004:5000 04-demo-debian-slim
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
| `docker exec 04-demo-debian-slim /bin/sh` | Shell access granted |

## Teardown

```bash
docker stop 04-demo-debian-slim && docker rm 04-demo-debian-slim
```
