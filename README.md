## Web application for Dictyostelium International Conference
___Ruby on Rails web application for the Annual Dictyostelium International Conference___

[![Build Status](https://secure.travis-ci.org/dictyBase/dictyconference.png?branch=develop)](https://travis-ci.org/dictyBase/dictyconference) [![Coverage Status](https://coveralls.io/repos/dictyBase/dictyconference/badge.png?branch=develop)](https://coveralls.io/r/dictyBase/dictyconference) [![Dependency Status](https://gemnasium.com/dictyBase/dictyconference.png)](https://gemnasium.com/dictyBase/dictyconference) [![Code Climate](https://codeclimate.com/github/dictyBase/dictyconference.png)](https://codeclimate.com/github/dictyBase/dictyconference)

* [dicty12](http://dicty12.dictybase.org/)
* [dicty13](http://dicty13.dictybase.org/)
* [dicty15](http://dicty15.dictybase.org/)

# Getting started

## Cloning the repository
To begin with clone the repository from [Github/dictyconference](https://github.com/dictyBase/dictyconference).
 
```shell
git clone git://github.com/dictyBase/dictyconference.git
```
Then switch to the ```develop``` branch

```shell
cd dictyconference
git checkout develop
```

## About Ruby on Rails and related 

##### Installation & Configuration on Mac OS X (Mavericks)
We manage Ruby versions using `rbenv`. To install and use it, check out their [instructions](https://github.com/sstephenson/rbenv). This is a summary (Sep 2014):

```shell
brew update
brew install rbenv ruby-build
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
rbenv install 2.1.2
```
Then, go to the github project folder (e.g. `dictyconference`), and on the branch that you are using to make changes do:

1. Create the file `.ruby-version` and include the installed version (i.e. 1.9.3-p429)
2. Add the file `.ruby-version` file to `.gitignore`

This will automatically make `rbenv` to choose the specified Ruby version when you are in this directory.

Install all the dependencies using ```bundler```

```bash
bundle install
```

##### Development:

`rails server` will let you see the changes as you develop.

## Configuration

The details of the configuration has changed for the [dicty15](http://dicty15.dictybase.org/) conference version with respect to previos version (check [old configuration](#oldconfig) below. The details of the configuration that has changed are those related to our host (NUBIC).

* database. They don’t use `bcdatabase` anymore. Instead, they now use [Confluence](https://confluence.nubic.northwestern.edu/dashboard.action). 

* Deployment. Nubic uses the `gem [capistrano](https://rubygems.org/gems/capistrano)`. This gem takes care of the deployment itself. For example, it creates the current version of the web and reorganize the structure of the folder to keep the old versions. `dictyconference` is not using this option yet. IN the meantime, a simple rsync is made with the servers.
* Refresh. After sync to staging and prod, a `touch tmp/restart.txt` might be necessary.

<a name="oldconfig"/>
## Old configuration

##### [reCAPTCHA](https://www.google.com/recaptcha)

##### bcdatabase
[NUBIC](http://www.nucats.northwestern.edu/clinical-research-resources/data-collection-biomedical-informatics-and-nubic/bioinformatics-overview.html) has a library and utility called [```bcdatabase```](https://github.com/NUBIC/bcdatabase) which provides database configuration parameter management for Ruby on Rails applications. It provides a simple mechanism for separating database configuration attributes from application source code so that there's no temptation to check passwords into the version control system.

Before we can use this gem we have to modify the ```Gemfile``` to add the following source and gem

```ruby
gem 'bcdatabase', '1.2.3'
```

If you want to use `bcdatabase` for the `staging` your application, your `./config/database.yml` file will look like this

```yaml
<%
  require 'bcdatabase'
  bcdb = Bcdatabase.load
%>

development:
  adapter: sqlite3
  database: db/development.sqlite3
  pool: 5
  timeout: 5000

test:
  adapter: sqlite3
  database: db/test.sqlite3
  pool: 5
  timeout: 5000

production:
  adapter: sqlite3
  database: db/production.sqlite3
  pool: 5
  timeout: 5000

<%= bcdb.staging :pstage, 'dictyConf' %>
```

The `pstage` parameter points to a configuration block `dictyConf` in a YAML file `/etc/nubic/db/pstage.yml` (on your staging server). This configuration block which will have the actual database configuration looks like

```yaml
dictyConf:
  database: <db_name>
  username: <db_user>
  epassword: <encrypted_password>
```

Also for the ```bcdb.staging``` (from ERB block) to work, you will have to create a ```staging.rb``` file in ```./config/environments/```

```shell
cp development.rb staging.rb
```

##### Tests

To use `rspec`, add following to the `Gemfile`

```ruby
gem "rspec-rails", ">= 2.0.1", :group => [:development, :test]
gem 'assert_difference', :group => [:test]
```

##### [Coveralls](https://coveralls.io/) for code coverage

Add this to your `Gemfile`, 

```ruby
gem 'coveralls', require: false
```

##### Final steps
Install all the dependencies using ```bundler```

```bash
bundle install
```

And before you deploy you will have to migrate your database under the staging environment.

```rails
RAILS_ENV=staging rake db:migrate
```

Ask your system administrator to setup your application with Apache server and you are good to go.

