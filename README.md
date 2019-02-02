# Blog creator API

## Contents
- [Contributing](#contributing)
  - [How to setup?](#how-to-setup)
  - [Environment variables](#environment-variables)
- [Links](#links)

## Contributing

### How to setup?

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
### Environment variables
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

## Links

- [Front-End](https://github.com/v-lavs/blog-creator)