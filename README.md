# SMS Two Factor Authentication with Ruby on Rails and Twilio

SMS Two Factor Authentication implementation with Ruby on Rails and Twilio

[![Build Status](https://travis-ci.org/TwilioDevEd/sms2fa-rails.svg?branch=master)](https://travis-ci.org/TwilioDevEd/sms2fa-rails)
[![Coverage Status](https://coveralls.io/repos/github/TwilioDevEd/sms2fa-rails/badge.svg?branch=master)](https://coveralls.io/github/TwilioDevEd/sms2fa-rails?branch=master)

## Local Development

This project is built using [Ruby on Rails](http://rubyonrails.org/) Framework.

1. First clone this repository and `cd` into it

   ```
   git clone git@github.com:TwilioDevEd/sms2fa-rails.git
   cd sms2fa-rails
   ```

1. Install the dependencies

   ```
   bundle
   ```

1. Export the environment variables

   You can find the `AccountSID` and the `AuthToken` at https://www.twilio.com/user/account/settings.
   ```
   export TWILIO_ACCOUNT_SID=Your Twilio Account SID
   export TWILIO_AUTH_TOKEN=Your Twilio Auth Token
   export TWILIO_NUMBER=Your Twilio Phone Number
   ```

1. Create database and run migrations

   _Make sure you have installed [PostgreSQL](http://www.postgresql.org/). If on
   a Mac, I recommend [Postgres.app](http://postgresapp.com)_.

   ```
   bundle exec rake db:setup
   ```

1. Make sure the tests succeed

   ```
   bundle exec rspec
   ```

1. Run the server

   ```
   rails s
   ```

1. Check it out at [http://localhost:3000](http://localhost:3000)


That's it!

## Meta

* No warranty expressed or implied. Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.
