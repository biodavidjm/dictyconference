source 'http://rubygems.org'

gem 'rails', '3.0.20'

# PostgreSQL for production & staging
group :production, :staging do
	gem 'pg'
end

# SQLite for development & testing
group :development, :test do
	gem 'sqlite3-ruby', '1.2.5', :require => 'sqlite3'
end

gem 'authlogic'
gem 'recaptcha', :require => 'recaptcha/rails'
gem 'fastercsv'

# NUBIC's bcdatabase
group :prod, :staging do
	gem 'bcdatabase', '1.2.3'
end

# RSpec for testing
gem "rspec-rails", ">= 2.0.1", :group => [:development, :test]
gem 'assert_difference', :group => [:development, :test]

# Coveralls for calculating code coverage
gem 'coveralls', require: false
