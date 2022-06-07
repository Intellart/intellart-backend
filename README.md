# Veritheum API

## Getting Started

Follow these instructions to install GIT, RVM, Ruby and Rails:
https://gorails.com/setup/osx/11-big-sur

The ruby and rails version is written in the Gemfile.

### Additional dependencies

#### PostgreSQL

Install postgres.app:
https://postgresapp.com

#### NVM & Node.js

First install NVM:
https://github.com/creationix/nvm

Then install the correct version of node.js. The version is found in the package.json-file in the root directory.

#### Yarn

Install Yarn package manager:
https://yarnpkg.com/lang/en/docs/install/

### Install all ruby gems and node modules

Install all ruby gems by running:

    bundle install

Install mailcatcher gem by running:

    gem install mailcatcher

Install all node module by running:

    yarn install

### Prepare environment variables

Add `.env` file to root directory. Inside add the required variables to run the app localy (all secrets are distributed within the development team & the repo owner):
```
ALGORITHM_TYPE="<secret>"
API_KEY="<secret>"
FRONTEND_BASE_URL="http://localhost:3001"
FRONTEND_WS_URL="ws://localhost:3001"
ORCID_CLIENT_ID="<secret>"
ORCID_SECRET="<secret>"
REDIS_DB="<secret>"
REDIS_PORT="<secret>"
REDIS_URL="redis://localhost"
```

### Prepare application credentials

Run

    EDITOR="mate --wait" bin/rails credentials:edit

Replace the default master key with the one used to encrypt the credentials initially -
the key is distributed by the development team.

### Prepare the database

Run

    rails db:setup

### Running the application

Start rails application:

    rails s

Start mailcatcher:

    mailcatcher

Run sidekiq workers (*For now this is only a one time action, the ExchangeRates table should have at least one entry*):

    rails c
    GetCurrentExchangeRatesJob.perform_now

Run with full action cable functionality in development (by default it will not broadcast models & jobs):
- In `cable.yml` make the following change

      development:
        adapter: redis
        url: <%= ENV.fetch('REDIS_URL', 'redis://localhost') %>:<%= ENV.fetch('REDIS_PORT', 6379) %>/<%= ENV.fetch('REDIS_DB', 0) %>

- In new terminal run

      redis-server

Run RSpec tests:

    rspec