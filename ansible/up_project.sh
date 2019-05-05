#!/usr/bin/env bash

# enable swap
dd if=/dev/zero of=/swapfile1 bs=1024 count=524288
chown root:root /swapfile1
chmod 0600 /swapfile1
mkswap /swapfile1
swapon /swapfile1

cd /home/ubuntu/blog_creator_api/current

docker-compose -f docker-compose.production.yml stop
docker-compose -f docker-compose.production.yml build
docker-compose -f docker-compose.production.yml run --rm web rails db:migrate
docker-compose -f docker-compose.production.yml run --rm web rails assets:precompile
docker-compose -f docker-compose.production.yml run --rm web rails assets:sync
docker-compose -f docker-compose.production.yml stop
docker-compose -f docker-compose.production.yml up -d
sleep 5
docker ps

swapoff /swapfile1
rm /swapfile1