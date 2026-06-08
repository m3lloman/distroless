# Build from this folder: docker build -f Dockerfile -t 08-demo-chainguard-python .
# Uses cgr.dev/chainguard/python:latest-dev to install deps, runtime is python:latest.
# No shell in runtime image -- same exploit, same failure as 06/07.

FROM cgr.dev/chainguard/python:latest-dev AS builder

WORKDIR /app
COPY requirements.txt app.py ./
RUN pip install --no-cache-dir -r requirements.txt --target /app/packages

FROM cgr.dev/chainguard/python:latest

WORKDIR /app
COPY --from=builder /app/packages /app/packages
COPY --from=builder /app/app.py .

ENV PYTHONPATH=/app/packages
ENV FLASK_APP=app.py

EXPOSE 5000

# Chainguard python image already runs as uid 65532 (nonroot)
ENTRYPOINT ["/usr/bin/python", "-m", "flask", "run", "--host=0.0.0.0"]
