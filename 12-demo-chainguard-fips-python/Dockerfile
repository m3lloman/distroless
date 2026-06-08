# Build from this folder: docker build -f Dockerfile -t 12-demo-chainguard-fips-python .
# Builder installs deps, runtime is FIPS-validated Python (no shell).
# IMPORTANT: Read the image overview before using this image in production.
# https://images.chainguard.dev/directory/image/python-fips/overview

FROM cgr.dev/chainguard/python-fips:3.13-dev AS builder

WORKDIR /app
COPY requirements.txt app.py ./
RUN pip install --no-cache-dir -r requirements.txt --target /app/packages

FROM cgr.dev/chainguard/python-fips:3.13

WORKDIR /app
COPY --from=builder /app/packages /app/packages
COPY --from=builder /app/app.py .

ENV PYTHONPATH=/app/packages
ENV FLASK_APP=app.py

EXPOSE 5000

# Already runs as uid=65532 (nonroot)
ENTRYPOINT ["/usr/bin/python", "-m", "flask", "run", "--host=0.0.0.0"]
