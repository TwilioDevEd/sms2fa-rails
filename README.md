<a href="https://www.twilio.com">
  <img src="https://static0.twilio.com/marketing/bundles/marketing/img/logos/wordmark-red.svg" alt="Twilio" width="250" />
</a>

# SMS Two Factor Authentication with Ruby on Rails and Twilio

An example application implementing SMS Two Factor Authentication using Twilio.


[Read the full tutorial here](https://www.twilio.com/docs/tutorials/walkthrough/sms-two-factor-authentication/ruby/rails)!


[![Build Status](https://travis-ci.org/TwilioDevEd/sms2fa-rails.svg?branch=master)](https://travis-ci.org/TwilioDevEd/sms2fa-rails)
[![Coverage Status](https://coveralls.io/repos/github/TwilioDevEd/sms2fa-rails/badge.svg?branch=master)](https://coveralls.io/github/TwilioDevEd/sms2fa-rails?branch=master)

## Local Development

This project is built using [Ruby on Rails](http://rubyonrails.org/) Framework.

1. First clone this repository and `cd` into it.

   ```bash
   $ git clone git@github.com:TwilioDevEd/sms2fa-rails.git
   $ cd sms2fa-rails
   ```

1. Install the dependencies.

   ```bash
   $ bundle install
   ```

1. Copy the `.env.example` file to `.env`, and edit it including your credentials
   for the Twilio API (found at https://www.twilio.com/console/account/settings). You
   will also need a [Twilio Number](https://www.twilio.com/console/phone-numbers/incoming).

   Run `source .env` to export the environment variables.

1. Create database and run migrations.

   _Make sure you have installed [PostgreSQL](http://www.postgresql.org/). If on
   a Mac, I recommend [Postgres.app](http://postgresapp.com)_.

   ```bash
   $ bundle exec rake db:setup
   ```

1. Make sure the tests succeed.

   ```bash
   $ bundle exec rspec
   ```

1. Start the server.

   ```bash
   $ bundle exec rails s
   ```

1. Check it out at [http://localhost:3000](http://localhost:3000).

## Meta

* No warranty expressed or implied. Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.
