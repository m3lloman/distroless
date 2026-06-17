# 10-demo-chainguard-node

Same command injection vulnerability in Express. Runtime: cgr.dev/chainguard/node.

NOTE: cgr.dev/chainguard/node:latest includes busybox and /bin/sh -- npm
lifecycle scripts require a shell. The exploit WORKS on this container.
This is intentional: it demonstrates that "Chainguard" does not automatically
mean "no shell". Runtime requirements drive what gets included.

uid=65532 (nonroot), but shell is present and exploit executes.

## Build and run

```bash
docker build -f Dockerfile -t 10-demo-chainguard-node .
docker run -d --name 10-demo-chainguard-node -p 5010:5000 10-demo-chainguard-node
```

## Key behaviors

| Action | Result |
|---|---|
| `/ping?host=8.8.8.8` | JSON ping response -- shell present, command runs |
| `/ping?host=8.8.8.8; id` | Command injection works, returns uid output |
| `docker exec 10-demo-chainguard-node /bin/sh` | Shell access granted via busybox |

## Teardown

```bash
docker stop 10-demo-chainguard-node && docker rm 10-demo-chainguard-node
```
