# ParkRent

**Ruby 2.0** / **Rails 4**

## Getting started

    touch .env.local
    cp .env.default .test-env.development
    cp .env.default .env.test
    cp .env.default .env.production

    bundle install
    bundle exec rake db:create
    bundle exec rake db:migrate
    bundle exec foreman start


## Running tests

    bundle exec guard


