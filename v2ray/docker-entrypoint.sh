#!/bin/sh

set -xe

CONF_TPL_PATH='/v2ray/conf.tpl.jsonc'
CONF_PATH='/v2ray/config.jsonc'

if [ -z $DOCKER_ENV ]; then
  CONF_TPL_PATH='v2ray/conf.tpl.jsonc'
  CONF_PATH='v2ray/conf.jsonc'
  rm -f $CONF_PATH
fi

if [ ! -f $CONF_PATH ];then
  set +x
  tpl=$(cat $CONF_TPL_PATH)
  tpl=${tpl//'{{VMESS_ID}}'/${VMESS_ID:-'8982bac0-e1fc-4c09-bea3-3a0e402fabd3'}}
  tpl=${tpl//'{{PROXY_PATH}}'/${PROXY_PATH:-'/ray'}}
  set -x
  echo "$tpl" > $CONF_PATH
fi

exec $@
