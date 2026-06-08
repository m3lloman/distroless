# Build from this folder: docker build -f Dockerfile -t 07-demo-scratch ..
# Multistage: Alpine builds, scratch runtime has no shell.
# subprocess(shell=True) fails with ENOENT -- /bin/sh does not exist.

FROM alpine:3.20 AS builder

RUN apk add --no-cache python3 py3-pip && \
    adduser -D -u 10001 appuser

WORKDIR /app
COPY app/ .
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

RUN set -e && mkdir -p /runtime/lib /runtime/usr/lib /runtime/usr/bin /runtime/app && \
    \
    # musl + libs that live under /lib
    cp /lib/ld-musl-*.so.1  /runtime/lib/ && \
    cp /lib/libz.so.1       /runtime/lib/ && \
    cp /lib/libssl.so.3     /runtime/lib/ && \
    cp /lib/libcrypto.so.3  /runtime/lib/ && \
    \
    # all /usr/lib shared libraries Python extension modules need
    cp /usr/lib/libpython3.12.so.1.0    /runtime/usr/lib/ && \
    cp /usr/lib/libbz2.so.1             /runtime/usr/lib/ && \
    cp /usr/lib/libexpat.so.1           /runtime/usr/lib/ && \
    cp /usr/lib/libffi.so.8             /runtime/usr/lib/ && \
    cp /usr/lib/libgdbm.so.6            /runtime/usr/lib/ && \
    cp /usr/lib/libgdbm_compat.so.4     /runtime/usr/lib/ && \
    cp /usr/lib/liblzma.so.5            /runtime/usr/lib/ && \
    cp /usr/lib/libmpdec.so.4           /runtime/usr/lib/ && \
    cp /usr/lib/libncursesw.so.6        /runtime/usr/lib/ && \
    cp /usr/lib/libpanelw.so.6          /runtime/usr/lib/ && \
    cp /usr/lib/libreadline.so.8        /runtime/usr/lib/ && \
    cp /usr/lib/libsqlite3.so.0         /runtime/usr/lib/ && \
    cp /usr/lib/libgcc_s.so.1           /runtime/usr/lib/ && \
    cp /usr/lib/libstdc++.so.6          /runtime/usr/lib/ && \
    \
    # Python stdlib + site-packages (flask and deps land here)
    cp -a /usr/lib/python3.12           /runtime/usr/lib/ && \
    \
    # python3.12 binary
    cp /usr/bin/python3.12              /runtime/usr/bin/python3 && \
    \
    # app
    cp -a /app/. /runtime/app/

# ── Runtime stage ──────────────────────────────────────────────────────────
FROM scratch

COPY --from=builder /runtime/ /
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group  /etc/group

ENV PYTHONHOME=/usr
ENV PYTHONPATH=/app
ENV FLASK_APP=app.py

USER 10001
WORKDIR /app
EXPOSE 5000

ENTRYPOINT ["/usr/bin/python3", "-m", "flask", "run", "--host=0.0.0.0"]
