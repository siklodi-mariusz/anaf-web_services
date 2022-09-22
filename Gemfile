# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in anaf-web_services.gemspec
gemspec

gem 'rake', '~> 13.0'

gem 'rspec', '~> 3.0'

gem 'rubocop', '~> 1.21'

group :development do
  gem 'guard-rspec', require: false
end

group :test do
  gem 'webmock', '~> 3.18', '>= 3.18.1'
end

group :development, :test do
  gem 'byebug'
end
