# 03-demo-ubi

Vulnerable Flask app on ubi9/ubi:latest. Shell present, exploit works.

## Build and run

```bash
docker build -f Dockerfile -t 03-demo-ubi ..
docker run -d --name 03-demo-ubi -p 5003:5000 03-demo-ubi
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
| `docker exec 03-demo-ubi /bin/sh` | Shell access granted |

## Teardown

```bash
docker stop 03-demo-ubi && docker rm 03-demo-ubi
```
