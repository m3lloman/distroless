# Build from this folder: docker build -f Dockerfile -t 02-demo-alpine ..

FROM alpine:3.20

RUN apk add --no-cache python3 py3-pip iputils && \
    adduser -D -u 10001 appuser

WORKDIR /app
COPY app/ .

RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

USER appuser
EXPOSE 5000

CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0"]
