#!/bin/sh
gcloud docker -- push gcr.io/bitcoinpages-185710/bitcoind:v1
gcloud docker -- push gcr.io/bitcoinpages-185710/wallet:v1
gcloud docker -- push gcr.io/bitcoinpages-185710/bitcoinpages-home:v1
