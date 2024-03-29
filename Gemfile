source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
 "https://github.com/#{repo_name}.git"
end

gem 'rails',          '>=5.1.4'
gem 'bcrypt',         '>=3.1.11'
gem 'bootstrap-sass', '>=3.3.7'
gem 'puma',           '>=3.4.0'
gem 'sass-rails',     '>=5.0.6'
gem 'uglifier',       '>=3.0.0'
gem 'coffee-rails',   '>=4.2.1'
gem 'jquery-rails',   '>=4.1.1'
gem 'turbolinks',     '>=5.0.1'
gem 'jbuilder',       '>=2.4.1'
gem 'faker',          '>=1.7.3'
gem 'will_paginate',  '>=3.1.5'
gem 'bootstrap-will_paginate', '>=1.0.0'
gem 'carrierwave',    '>=1.1.0'
gem 'mini_magick',    '>=4.7.0'

gem 'ruby-oci8'
gem 'activerecord-oracle_enhanced-adapter', '~> 1.8.0'

gem 'dotenv-rails'
gem 'keen'

# Fog is used for downloading/uploading images to a cloud solution.
# No images yet, so comment it out:
# gem 'fog',            '>=1.40.0'

gem 'mongoid',        '~>6.1.0'

group :development, :test do
  gem 'sqlite3', '>=1.3.12'
  gem 'byebug',  '>=9.0.0', platform: :mri
end

group :development do
  gem 'web-console',           '>=3.1.1'
  gem 'listen',                '>=3.0.8'
  gem 'spring',                '>=1.7.2'
  gem 'spring-watcher-listen', '>=2.0.0'
end

group :test do
  gem 'minitest', '~> 5.10', '!= 5.10.2'
  gem 'rails-controller-testing', '>=0.1.1'
  gem 'minitest-reporters',       '>=1.1.9'
  gem 'guard',                    '>=2.13.0'
  gem 'guard-minitest',           '>=2.4.4'
end

group :production do
  gem 'pg', '>=0.18.4'
  gem 'sendgrid-ruby'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
