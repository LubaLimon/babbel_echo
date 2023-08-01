# README
Echo uses Ruby 3.0 and Rails 7.0

## Configuring a database
Echo uses passwordless Postgres database by default.
To setup a database run   
`rails db:create`   
`rails db:migrate`   

## Running a server
Run   
`bundle install`   
`rails s`   
to start server with default settings

## Running tests
Rspec is used as test framework   
`bundle install`   
`bundle exec rspec`   
To run a test suite
