source 'http://rubygems.org'
# source 'http://download.bioinformatics.northwestern.edu/gems/'

gem 'rails', '3.0.20'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'pg'
gem 'authlogic'
gem 'recaptcha', :require => 'recaptcha/rails'
gem 'fastercsv'

# NUBIC's bcdatabase
group :prod, :staging do
	gem 'bcdatabase', '1.2.1'
end

# RSpec for testing
#group :test do
#  gem 'rspec-rails'
#end

# SQLite
group :development do
	gem 'sqlite3-ruby', '1.2.5', :require => 'sqlite3'
end
