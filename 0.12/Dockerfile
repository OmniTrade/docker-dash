FROM debian:stable-slim

LABEL maintainer.0="João Fonseca (@joaopaulofonseca)" \
  maintainer.1="Pedro Branco (@pedrobranco)" \
  maintainer.2="Rui Marinho (@ruimarinho)" \
  editor.0="Bruno Amaral F (@bamaralf)"

ENV GOSU_VERSION=1.10
ENV GOSU_SHA256=5b3b03713a888cee84ecbf4582b21ac9fd46c3d935ff2d7ea25dd5055d302d3c
ENV DASH_VERSION=0.12.3.2
ENV DASH_SHA256=1c80bc79451da100c38c431fc8f9ff8e35e6f30a65df7b4200f8b01344453c70
ENV DASH_FOLDER_VERSION=0.12.3
ENV DASH_DATA=/home/dash/.dashcore \
  PATH=/opt/dashcore-${DASH_FOLDER_VERSION}/bin:$PATH

RUN useradd -r dash \
  && apt-get update -y \
  && apt-get install -y curl gnupg unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && set -ex \
  && curl -o /usr/local/bin/gosu -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture) \
  && echo "$GOSU_SHA256 /usr/local/bin/gosu" | sha256sum -c - \
  && chmod +x /usr/local/bin/gosu \
  && curl -SLO https://github.com/dashpay/dash/releases/download/v${DASH_VERSION}/dashcore-${DASH_VERSION}-x86_64-linux-gnu.tar.gz \
  && ls -lah \
	&& echo "$DASH_SHA256 dashcore-${DASH_VERSION}-x86_64-linux-gnu.tar.gz" | sha256sum -c - \
  && tar -xzf dashcore-${DASH_VERSION}-x86_64-linux-gnu.tar.gz -C /opt \
  && rm *.tar.gz

VOLUME ["/home/dash/.dashcore"]

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9998 9999 18332 19998 19999

CMD ["dashd"]
