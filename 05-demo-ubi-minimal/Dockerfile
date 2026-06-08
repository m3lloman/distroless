# Build from this folder: docker build -f Dockerfile -t 05-demo-ubi-minimal ..
# ubi-minimal uses microdnf instead of dnf.

FROM registry.access.redhat.com/ubi9/ubi-minimal:latest

RUN microdnf install -y python3 python3-pip iputils shadow-utils && microdnf clean all && \
    useradd --no-create-home -u 10001 appuser

WORKDIR /app
COPY app/ .

RUN pip3 install --no-cache-dir -r requirements.txt

USER appuser
EXPOSE 5000

CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0"]
