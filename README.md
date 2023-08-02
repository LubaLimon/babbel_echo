# README
Echo uses Ruby 3.0 and Rails 7.0. API follows a format suggested by the echo.md.  

## Prerequisites
```
bundle install
```   
To install all gems.

## Configuring a database
Echo uses passwordless Postgres database by default.
To setup a database run   
```
rake db:create
rake db:migrate
```   

## Running a server
```
rails s
```   
to start server with default settings.

## Running tests
Rspec is used as test framework.   
To run a test suite  
```
bundle exec rspec
```   

