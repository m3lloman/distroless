# Build from this folder: docker build -f Dockerfile -t 01-demo-debian ..
# VULNERABLE baseline -- full debian:12 image
# Has /bin/sh, /bin/bash, curl, apt, and full package manager.
# The command injection in /ping works completely here.

FROM debian:12

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --no-create-home -u 10001 appuser

WORKDIR /app
# Context is repo root so COPY can reach ../app.
COPY app/ .

RUN pip3 install --break-system-packages -r requirements.txt

USER appuser
EXPOSE 5000

CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0"]
