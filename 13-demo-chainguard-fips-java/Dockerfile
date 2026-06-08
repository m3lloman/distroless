# Build from this folder: docker build -f Dockerfile -t 13-demo-chainguard-fips-java .
# Builder: FIPS JDK 17 dev  Runtime: FIPS JRE 17 (no shell, BouncyCastle FIPS provider).
# IMPORTANT: Read the image overview before using this image in production.
# https://images.chainguard.dev/directory/image/jdk-fips/overview
#
# CLASSPATH WARNING: The base image pre-sets CLASSPATH and JAVA_TOOL_OPTIONS to wire
# BouncyCastle FIPS as the JCE/JSSE security provider. When adding your own classes
# or jars, always prepend ${JAVA_FIPS_CLASSPATH} to keep BouncyCastle discoverable:
#   ENV CLASSPATH="${JAVA_FIPS_CLASSPATH}:/app/classes"
# You can also pass -cp explicitly as long as BouncyCastle is first:
#   CMD ["-cp", "${JAVA_FIPS_CLASSPATH}:classes", "demo.MyApp"]
# Never set CLASSPATH to only your classes -- that silently drops FIPS crypto.

FROM cgr.dev/chainguard/jdk-fips:openjdk-17-dev AS builder

WORKDIR /app
COPY src/main/java/demo/PingServer.java ./
RUN mkdir -p classes && javac -d classes PingServer.java

FROM cgr.dev/chainguard/jre-fips:openjdk-17

WORKDIR /app
COPY --from=builder /app/classes/demo ./demo

# Prepend JAVA_FIPS_CLASSPATH to keep BouncyCastle FIPS discoverable, then add our classes.
ENV CLASSPATH="${JAVA_FIPS_CLASSPATH}:/app"

EXPOSE 5000

# The base image ENTRYPOINT is: /usr/bin/java --module-path=/usr/share/java/bouncycastle-fips
# CMD is appended to ENTRYPOINT -- just the class name.
# Already runs as uid=65532 (nonroot)
CMD ["demo.PingServer"]
