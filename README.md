# README
## Password Service
### Description
When defining passwords for an account, it’s often useful to tell the users the level of security of the passwords they choose.
The goal of this challenge is to implement a system that helps our users select a good and strong password.
## Installation
### Clone project
Clone project using Git over SSH.
```sh
$ git clone git@github.com:jeandias/app-api.git
$ cd app-api
```
### Install dependencies for project
```sh
$ bundle install
$ rails db:migrate
```
### Start the server
```sh
$ rails server
```
## Tests API
### Rspec
```sh
$ bundle exec rspec
```
Or run:
```sh
$ bundle exec rspec spec/controllers/api/v1/users_controller_spec.rb
$ bundle exec rspec spec/models/user_spec.rb
```
