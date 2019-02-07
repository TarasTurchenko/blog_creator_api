# Blog creator API

## Contents
- [How to setup?](#how-to-setup)
- [Links](#links)

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

## Links

- [Front-End](https://github.com/v-lavs/blog-creator)
