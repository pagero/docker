FROM hashicorp/terraform:0.12.6 as hashicorp

FROM google/cloud-sdk:258.0.0-alpine
ARG KUBERNETES_VERSION=v1.14.10
ARG HELM_VERSION=v2.14.3
ARG SOPS_VERSION=3.3.1

ENV PATH=/kubernetes/client/bin:/helm/linux-amd64:/terraform:$PATH
RUN curl -sL https://dl.k8s.io/${KUBERNETES_VERSION}/kubernetes-client-linux-amd64.tar.gz \
  | tar -xzvf -
# Symlink common path set by host machines gcloud kube config
RUN ln -s /google-cloud-sdk /usr/lib/google-cloud-sdk

# Install Helm
RUN mkdir /helm
RUN curl -sL https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
  | tar -xzvf - -C /helm

RUN apk --update add \
  # Helm plugins require git
  # helm-diff requires bash, curl
  git bash \
  # Makefiles are commonly used as configuration
  make

# Install github.com/mozilla/sops
RUN curl -o /usr/local/bin/sops -L https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux
RUN chmod +x /usr/local/bin/sops

# Install Helm plugins
RUN helm init --client-only
RUN helm plugin install https://github.com/viglesiasce/helm-gcs.git
RUN helm plugin install https://github.com/databus23/helm-diff

# Install Terraform
RUN mkdir /terraform
COPY --from=hashicorp /bin/terraform /terraform/terraform


# Install kustomize
RUN apk add curl openssh \
  && git config --global url.ssh://git@github.com/.insteadOf https://github.com/ 
RUN  curl -L --output /tmp/kustomize_v3.3.0_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.3.0/kustomize_v3.3.0_linux_amd64.tar.gz \
  && echo "4b49e1bbdb09851f11bb81081bfffddc7d4ad5f99b4be7ef378f6e3cf98d42b6  /tmp/kustomize_v3.3.0_linux_amd64.tar.gz" | sha256sum -c \
  && tar -xvzf /tmp/kustomize_v3.3.0_linux_amd64.tar.gz -C /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize
