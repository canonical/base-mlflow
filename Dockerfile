ARG UBUNTU_VERSION
FROM ubuntu:$UBUNTU_VERSION
ARG VERSION

RUN apt update && apt install -y \
    python3.10 \
    python3-pip && \
    pip install --no-cache mlflow==$VERSION && \
    apt autoremove -yqq --purge && \
    apt clean

CMD ["python3"]
