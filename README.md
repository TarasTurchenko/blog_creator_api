# Blog creator API

## Contents
- [Contributing](#contributing)
  - [How to setup?](#contributing-setup)
  - [Environment variables](#contributing-envs)
- [Links](#links)

<h2 id="contributing">Contributing</h2>

<h3 id="contributing-setup">How to setup?</h3>

```bash
# Build images
docker-compose build

# Add required variables into .env

# Create database
docker-compose run --rm web rails db:create

# Run database migrations
docker-compose run --rm web rails db:mirgate

# Add test records into database (optional)
docker-compose run --rm web rails db:seed

# Run application
docker-compose up

```
<h3 id="contributing-envs">Environment variables</h3>
```dotenv
RAILS_ENV

# PostgreSQL
DB_HOST
DB_PORT
DB_DATABASE
DB_USERNAME
DB_PASSWORD

# Amazon
CLOUDFRONT
``` 

<h2 id="links">Links</h2>
- [Front-End](https://github.com/v-lavs/blog-creator)