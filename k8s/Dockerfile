FROM google/cloud-sdk:228.0.0-alpine
ARG KUBERNETES_VERSION=v1.13.0
ARG HELM_VERSION=v2.12.0

ENV PATH=/kubernetes/client/bin:/helm/linux-amd64:$PATH
RUN curl -sL https://dl.k8s.io/${KUBERNETES_VERSION}/kubernetes-client-linux-amd64.tar.gz \
  | tar -xzvf -
# Symlink common path set by host machines gcloud kube config
RUN ln -s /google-cloud-sdk /usr/lib/google-cloud-sdk

# Install Helm
RUN mkdir /helm
RUN curl -sL https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
  | tar -xzvf - -C /helm

# Helm plugins require git
# helm-diff requires bash, curl
RUN apk --update add git bash

# Install Helm plugins
RUN helm init --client-only
RUN helm plugin install https://github.com/viglesiasce/helm-gcs.git
RUN helm plugin install https://github.com/databus23/helm-diff
