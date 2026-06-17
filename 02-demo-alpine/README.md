# 02-demo-alpine

Vulnerable Flask app on alpine:3.20. Shell present, exploit works.

## Build and run

```bash
docker build -f Dockerfile -t 02-demo-alpine ..
docker run -d --name 02-demo-alpine -p 5002:5000 02-demo-alpine
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
| `docker exec 02-demo-alpine /bin/sh` | Shell access granted |

## Teardown

```bash
docker stop 02-demo-alpine && docker rm 02-demo-alpine
```
