FROM alpine:3.9.4@sha256:769fddc7cc2f0a1c35abb2f91432e8beecf83916c421420e6a6da9f8975464b6 as V2ray

RUN mkdir /usr/bin/v2ray \
  && wget -q -O - https://github.com/v2ray/v2ray-core/releases/download/v4.18.2/v2ray-linux-64.zip \
  | unzip -d /usr/bin/v2ray - v2ray v2ctl \
  && chmod +x /usr/bin/v2ray/*

FROM alpine:3.9.4@sha256:769fddc7cc2f0a1c35abb2f91432e8beecf83916c421420e6a6da9f8975464b6

COPY --from=V2ray /usr/bin/v2ray /usr/bin/v2ray
ENV PATH=$PATH:/usr/bin/v2ray

COPY v2ray /v2ray
RUN chmod +x /v2ray/docker-entrypoint.sh

ENV DOCKER_ENV=true
ENTRYPOINT [ "/v2ray/docker-entrypoint.sh" ]

WORKDIR /v2ray

CMD [ "v2ray", "-config", "/v2ray/config.jsonc" ]
