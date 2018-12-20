FROM google/cloud-sdk:228.0.0-alpine
ARG KUBERNETES_VERSION=v1.13.0

ENV PATH=/kubernetes/client/bin:$PATH
RUN curl -sL https://dl.k8s.io/${KUBERNETES_VERSION}/kubernetes-client-linux-amd64.tar.gz \
  | tar -xzvf -
RUN ln -s /google-cloud-sdk /usr/lib/google-cloud-sdk
