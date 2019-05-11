#!/usr/bin/env bash

cd /home/ubuntu/blog_creator_api/current

./ansible/deploy-frontend.sh

docker-compose -f docker-compose.production.yml stop
docker-compose -f docker-compose.production.yml rm -f -v
docker-compose -f docker-compose.production.yml build
docker-compose -f docker-compose.production.yml run --rm web rails db:migrate
docker-compose -f docker-compose.production.yml run --rm web yarn install
docker-compose -f docker-compose.production.yml run --rm web rails assets:precompile
docker-compose -f docker-compose.production.yml run --rm web rails assets:sync
docker-compose -f docker-compose.production.yml stop
docker-compose -f docker-compose.production.yml up -d

docker ps