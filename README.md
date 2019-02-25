# Blog creator API

## Contents
- [How to setup?](#how-to-setup)
- [API Documentation](#api-documentation)
- [Links](#links)

### How to setup?

- Firstly you have to add requires environment variables into your .env
- Prepare app dependencies and run server.

docker-compose:

```bash
# Build images
docker-compose build

# Create database
docker-compose run --rm web rails db:create

# Run database migrations
docker-compose run --rm web rails db:mirgate

# Add test records into database (optional)
docker-compose run --rm web rails db:seed

# Run application
docker-compose up

```

## API Documentation

Swagger documentation: `/api_docs`

## Links

- [Front-End](https://github.com/blog-creator-team/blog-creator)
