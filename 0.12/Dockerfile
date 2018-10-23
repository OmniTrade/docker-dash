FROM debian:stretch-slim

LABEL maintainer.0="João Fonseca (@joaopaulofonseca)" \
  maintainer.1="Pedro Branco (@pedrobranco)" \
  maintainer.2="Rui Marinho (@ruimarinho)" \
  editor.0="Bruno Amaral F (@bamaralf)"

ENV DASH_VERSION=0.12.3.3
ENV DASH_SHA256=19191193a8eaf5a10be08eaa3f33ea60c6a2b8848cd8cfeb8aa2046c962b32bd
ENV DASH_FOLDER_VERSION=0.12.3
ENV DASH_DATA=/data 
ENV DASH_PREFIX=/opt/dashcore-${DASH_FOLDER_VERSION}
ENV PATH=${DASH_PREFIX}/bin:$PATH

COPY docker-entrypoint.sh /entrypoint.sh
COPY rabbitmqadmin /usr/bin/rabbitmqadmin
COPY google-logger /usr/bin/google-logger  

RUN useradd -r dash \
  && set -ex \
  && apt-get update -y \
  && apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg curl python-setuptools python-pip procps \
# run pip
  && pip install --upgrade google-cloud-logging \
  && pip install --upgrade grpcio==1.7.3 \
# apt clean
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
# install binaries  
  && curl -SLO https://github.com/dashpay/dash/releases/download/v${DASH_VERSION}/dashcore-${DASH_VERSION}-x86_64-linux-gnu.tar.gz \
	&& echo "$DASH_SHA256 dashcore-${DASH_VERSION}-x86_64-linux-gnu.tar.gz" | sha256sum -c - \
  && tar -xzf dashcore-${DASH_VERSION}-x86_64-linux-gnu.tar.gz -C /opt \
  && rm *.tar.gz \
# create folders and set permissions to workdir
  && mkdir "$DASH_DATA" \
	&& chown -R dash: "$DASH_DATA" \
  && rm -rf /home/dash/.dashcore \
# set files permissions
  && chmod +x /usr/bin/rabbitmqadmin \
  && chmod +x /usr/bin/google-logger  

VOLUME ["/data"]

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9998 9999 18332 19998 19999

CMD ["dashd"]