# Blog creator API

## Contents
- [Contributing](#contributing)
  - [How to setup?](#contributing-setup)
  - [Environment variables](#contributing-envs)
- [Links](#links)

## Contributing {#contributing}

### How to setup? {#contributing-setup}

a) run
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
### Environment variables {#contributing-envs}
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
## Links #{links}
- Front-End