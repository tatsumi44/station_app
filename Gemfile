# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# gem "rails"
gem "sinatra"
gem "sinatra-contrib"
gem 'sinatra-activerecord'
gem 'rake'

group :production do
  gem 'pg' , '~> 0.18'
end

group :development do
  gem 'sqlite3'
end