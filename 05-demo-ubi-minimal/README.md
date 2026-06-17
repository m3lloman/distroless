# 05-demo-ubi-minimal

Vulnerable Flask app on ubi9/ubi-minimal:latest. Shell present, exploit works.
Uses microdnf instead of dnf. Fewer packages than full UBI.

## Build and run

```bash
docker build -f Dockerfile -t 05-demo-ubi-minimal ..
docker run -d --name 05-demo-ubi-minimal -p 5005:5000 05-demo-ubi-minimal
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
| `docker exec 05-demo-ubi-minimal /bin/sh` | Shell access granted |

## Teardown

```bash
docker stop 05-demo-ubi-minimal && docker rm 05-demo-ubi-minimal
```
