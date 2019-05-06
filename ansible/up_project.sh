#!/usr/bin/env bash

# enable swap
sudo dd if=/dev/zero of=/swapfile1 bs=1024 count=524288
sudo chown root:root /swapfile1
sudo chmod 0600 /swapfile1
sudo mkswap /swapfile1
sudo swapon /swapfile1

cd /home/ubuntu/blog_creator_api/current

docker-compose -f docker-compose.production.yml stop
docker-compose -f docker-compose.production.yml build
docker-compose -f docker-compose.production.yml run --rm web rails db:migrate
docker-compose -f docker-compose.production.yml run --rm web yarn install
docker-compose -f docker-compose.production.yml run --rm web rails assets:precompile
docker-compose -f docker-compose.production.yml run --rm web rails assets:sync
docker-compose -f docker-compose.production.yml stop
docker-compose -f docker-compose.production.yml up -d

sudo swapoff /swapfile1
sudo rm /swapfile1

docker ps