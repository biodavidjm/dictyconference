## Ruby on rails web application for dictybase conference 

This wiki will help you deploy the dictyConference Ruby on Rails application.

This [link](http://www.tutorialspoint.com/ruby-on-rails/rails-directory-structure.htm) will help you understand the directory structure of a rails application

# Cloning the repository
To begin with clone the repository from [Github/dictyconference](https://github.com/dictyBase/dictyconference/tree/feature/trial).
 
```bash
git clone git://github.com/dictyBase/dictyconference.git
```
Then switch to the ```feature/trial``` branch

```bash
cd dictyconference
git checkout feature/trial
```

# Setting up RVM
We will have the set up [RVM](https://rvm.beginrescueend.com/) so that you can use your version of gems. Just fire up your terminal and follow the steps to install ```rvm```.
Then install the version of Ruby you want to use for your application;

```bash
rvm install 1.9.2
```

To use this version of Ruby for you application, do

```bash
rvm use 1.9.2
```

Now create a gemset called 'dictyConf' for our application

```bash
rvm gemset create dictyConf
rvm use @dictyConf
```

Install [```rails```](http://rubyonrails.org/)

```bash
gem install rails
```

Next step is to install [```bundler```](http://gembundler.com/). It is a very handy gem. It will install all the gems from your ```Gemfile``` and set it up for application.

```bash
gem install bundler
```

# Setting up 'bcdatabase'
[NUBIC](http://www.nucats.northwestern.edu/clinical-research-resources/data-collection-biomedical-informatics-and-nubic/bioinformatics-overview.html) has a library and utility called [```bcdatabase```](https://github.com/NUBIC/bcdatabase) which provides database configuration parameter management for Ruby on Rails applications. It provides a simple mechanism for separating database configuration attributes from application source code so that there's no temptation to check passwords into the version control system.

Before we can use this gem we have to modify the ```Gemfile``` to add the following source and gem

```ruby
source 'http://download.bioinformatics.northwestern.edu/gems/'

gem 'bcdatabase', '1.2.1'
```

It is pretty easy to use this gem (now that we have figured it out). When you create a rails application using ```rails new <app_name>```, a database configuration file is created in ```./config/database.yml``` which looks like (default)

```yaml
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
```

If you want to use ```bcdatabase``` for the staging your application, your ```./config/database.yml``` file will look like this

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

The ```pstage``` parameter points to a configuration block ```dictyConf``` in a YAML file ```/etc/nubic/db/pstage.yml``` (on your staging server). This configuration block which will have the actual database configuration looks like

```yaml
dictyConf:
  database: <db_name>
  username: <db_user>
  epassword: <encrypted_password>
```

Also for the ```bcdb.staging``` (from ERB block) to work, you will have to create a ```staging.rb``` file in ```./config/environments/```

```bash
cp development.rb staging.rb
```

# Final steps
Install all the dependencies using ```bundler```

```bash
bundle install
```

And before you deploy you will have to migrate your database under the staging environment.

```rails
RAILS_ENV=staging rake db:migrate
```

Ask your system administrator to setup your application with Apache server and you are good to go.

# Testing
You can use [```rspec```](http://rspec.info/) or [```factory_girl```](https://github.com/thoughtbot/factory_girl) for ```fixtures```.
