#!/bin/bash
set -e

# setup dcos cli
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

# authN with dcos using service account
cat service_account_secret | ./jq -r .private_key > service_account_key.pem
chmod 600 service_account_key.pem
./dcos cluster setup https://leader.mesos --ca-certs=.ssl/ca-bundle.crt --username=$SERVICE_ACCOUNT --private-key=service_account_key.pem

# install dcos enterprise cli
./dcos package install dcos-enterprise-cli --yes

# create service crt and key
ID=$(echo $MARATHON_APP_ID | sed 's/\///g')
./dcos security cluster ca newcert --cn $ID.marathon.l4lb.thisdcos.directory --name-c US --name-st CA --name-o "Mesosphere, Inc" --name-l "San Francisco" --key-algo rsa --key-size 2048 --host $ID.marathon.l4lb.thisdcos.directory -j > servicecert.json
cat servicecert.json | ./jq -r .certificate > service.crt
cat servicecert.json | ./jq -r .private_key > service.key
