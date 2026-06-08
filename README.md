# Distroless Containers: Less OS, Less Risk

Companion repository for the talk presented at BSides Tampa 2025.

## Abstract

Container images often ship with way more packages and software than an application actually needs: shells, package managers, debugging tools, and libraries that increase vulnerability noise and give attackers useful post-exploitation tooling. Distroless containers take a different approach by packaging only the application, its runtime, and the minimum required dependencies.

This talk explains how distroless images reduce security exposure, where they fit into modern container hardening guidance, and what tradeoffs teams should expect when adopting them. We compare traditional base images with distroless alternatives, discuss why removing shells and unused software matters, and connect the topic to recent Linux privilege-escalation and container escape concerns such as Copy Fail and Dirty Frag.

Attendees leave with a practical understanding of how to improve the security posture of their container environments along with samples they can use after the talk. The goal is not to claim distroless is magic, but to show how it meaningfully reduces attacker convenience and operational attack surface when combined with good container security hygiene.

## About the Speaker

Mello is a Greater Tampa Bay security architect and self-described cigar smoking security greybeard with 35 years of experience securing SaaS, cloud, and application platforms. He has spent his career helping teams turn security requirements into practical engineering patterns, from infrastructure hardening to application security and compliance. Mello has multiple certifications, is a published author and speaker, and a named inventor on a security-related patent.

## Demo Structure

Each demo runs the same vulnerable command-injection Flask/Java/Go/Node app so the only variable is the base image. The progression moves from bloated traditional images to minimal distroless and FIPS-validated images.

### Traditional base images (shell present, exploit works)

| Demo | Base image | Notes |
|---|---|---|
| [01-demo-debian](01-demo-debian/) | `debian:12` | Full OS, shell present |
| [02-demo-alpine](02-demo-alpine/) | `alpine:3.20` | Shell present |
| [03-demo-ubi](03-demo-ubi/) | `ubi9/ubi:latest` | Shell present |
| [04-demo-debian-slim](04-demo-debian-slim/) | `debian:12-slim` | Strips docs/locales, same package count |
| [05-demo-ubi-minimal](05-demo-ubi-minimal/) | `ubi9/ubi-minimal:latest` | Fewer packages, shell still present |

### Scratch / manual distroless (no shell)

| Demo | Base image | Notes |
|---|---|---|
| [06-demo-scratch-go](06-demo-scratch-go/) | `scratch` | Static Go binary, nothing else |
| [07-demo-scratch-python](07-demo-scratch-python/) | `scratch` | Manually assembled Python runtime |

### Chainguard distroless (no shell, Wolfi-based)

| Demo | Base image | Notes |
|---|---|---|
| [08-demo-chainguard-python](08-demo-chainguard-python/) | `cgr.dev/chainguard/python` | uid=65532, no shell |
| [09-demo-chainguard-java](09-demo-chainguard-java/) | `cgr.dev/chainguard/jre` | uid=65532, no shell |
| [10-demo-chainguard-node](10-demo-chainguard-node/) | `cgr.dev/chainguard/node` | Note: latest tag includes busybox |
| [11-demo-chainguard-go](11-demo-chainguard-go/) | `cgr.dev/chainguard/static` | uid=65532, no shell |

### Chainguard FIPS distroless (no shell, FIPS-validated crypto)

| Demo | Base image | Notes |
|---|---|---|
| [12-demo-chainguard-fips-python](12-demo-chainguard-fips-python/) | `cgr.dev/chainguard/python-fips` | FIPS-validated crypto, no shell |
| [13-demo-chainguard-fips-java](13-demo-chainguard-fips-java/) | `cgr.dev/chainguard/jre-fips` | BouncyCastle FIPS provider, no shell |
| [14-demo-chainguard-fips-node](14-demo-chainguard-fips-node/) | `cgr.dev/chainguard/node-fips` | Slim variant, no shell |
| [15-demo-chainguard-fips-go](15-demo-chainguard-fips-go/) | `cgr.dev/chainguard/glibc-openssl-fips` | FIPS OpenSSL, no shell |

## Running a Demo

Each demo folder has its own `README.md` with build and run instructions. The general pattern:

```bash
cd <demo-folder>
docker build -t <demo-name> .
docker run -p 5000:5000 <demo-name>
# then curl http://localhost:5000
```
