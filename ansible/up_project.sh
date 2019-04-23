#!/usr/bin/env bash

cd /home/ubuntu/blog_creator_api/current

docker-compose -f docker-compose.production.yml down
docker-compose -f docker-compose.production.yml build
docker-compose -f docker-compose.production.yml run --rm web rails db:migrate
docker-compose -f docker-compose.production.yml stop
docker-compose -f docker-compose.production.yml up -d
sleep 5
docker ps