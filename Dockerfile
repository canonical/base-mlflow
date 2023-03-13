FROM ubuntu:22.04
ARG VERSION

ENV TZ=UTC

RUN set -eux; \
    # install python
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get full-upgrade -y; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3.10 \
    python3-pip \
    tzdata; \
    DEBIAN_FRONTEND=noninteractive apt-get remove --purge --auto-remove -y; \
    rm -rf /var/lib/apt/lists/*; \
    # install mlflow
    pip install --no-cache mlflow==$VERSION
# to stay consistent with upstream image we separate the dpkg-query to separate layer
RUN mkdir -p /usr/share/rocks; \
    (echo "# os-release" && cat /etc/os-release && echo "# dpkg-query" && dpkg-query -f '${db:Status-Abbrev},${binary:Package},${Version},${source:Package},${Source:Version}\n' -W) > /usr/share/rocks/dpkg.query

EXPOSE 5000
CMD ["python3"]
