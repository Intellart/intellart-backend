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
API_KEY="<secret>"
ALGORITHM_TYPE="<secret>"
ORCID_CLIENT_ID="<secret>"
ORCID_SECRET="<secret>"
FRONTEND_BASE_URL="http://localhost:3001"
```

### Prepare application credentials

Run

    EDITOR="mate --wait" bin/rails credentials:edit

Replace the default master key with the one used to encrypt the credentials initially -
the key is distributed by the development team.

### Prepare the database

Run

    rails db:create
    rails db:migrate
    rails db:seed

### Running the application

Start rails application:

    rails s

Start mailcatcher:

    mailcatcher