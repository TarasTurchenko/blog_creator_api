# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'aws-sdk-cloudfront', '~> 1.0.0.rc2'
gem 'aws-sdk-s3', '~> 1.0.0.rc2'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'carrierwave', '~> 1.0'
gem 'fog-aws'
gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'grape-swagger-rails'
gem 'jwt'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cors'
gem 'rails', '~> 5.2.2'
gem 'sass-rails', '~> 5.0'
gem 'sorcery'
gem 'yui-compressor', '~> 0.12.0', require: 'yui/compressor'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
end

group :development do
  gem 'annotate'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
