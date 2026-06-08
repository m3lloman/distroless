# 07-demo-scratch

Same vulnerable Flask app as 01-demo-debian, built on FROM scratch.
Alpine builder stage, Python runtime manually assembled, no shell in the image.

subprocess(shell=True) calls /bin/sh which does not exist -- returns HTTP 500.

## Build and run

```bash
docker build -f Dockerfile -t 07-demo-scratch ..
docker run -d --name 07-demo-scratch -p 5007:5000 07-demo-scratch
```

## Demo

```bash
./demo.sh
```

## Key behaviors

| Action | Result |
|---|---|
| Homepage `/` | 200 OK -- pure Python, no subprocess |
| `/ping?host=8.8.8.8` | 500 -- subprocess(shell=True) needs /bin/sh |
| `/ping?host=8.8.8.8; id` | 500 -- exploit never runs |
| `docker exec 07-demo-scratch /bin/sh` | OCI error -- /bin/sh does not exist |
| `docker exec 07-demo-scratch ls /bin` | OCI error -- ls does not exist |

## Teardown

```bash
docker stop 07-demo-scratch && docker rm 07-demo-scratch
```
