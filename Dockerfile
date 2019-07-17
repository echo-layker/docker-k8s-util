FROM alpine

# docker build --no-cache --build-arg HELM_VERSION=2.14.1 --build-arg  KUBECTL_VERSION=1.14.0 -t alpine/helm:2.12.0 .

ARG HELM_VERSION=2.14.1
ARG KUBECTL_VERSION=1.14.0

# ENV BASE_URL="https://storage.googleapis.com/kubernetes-helm"
ENV BASE_URL="https://get.helm.sh"
ENV TAR_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"
# 切换KubeConfig
ENV KUBECONFIG="/root/.kube/config"
RUN apk add --update --no-cache curl ca-certificates && \
    curl -L ${BASE_URL}/${TAR_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/bin/kubectl && \
    apk del curl && \
    rm -f /var/cache/apk/*

WORKDIR /apps

ENTRYPOINT ["/bin/sh"]
# CMD ["kubectl","get","nodes"]