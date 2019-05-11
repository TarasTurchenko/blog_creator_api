#!/usr/bin/env bash

if [[ ! -d frontend ]]; then
    git clone git@github.com:blog-creator-team/blog-creator.git frontend
else
    cd ./frontend
    git pull
    cd ..
fi

aws s3 cp ./frontend/dist/assets s3://blog-creator/assets --recursive --acl public-read