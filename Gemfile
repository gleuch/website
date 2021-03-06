source 'https://rubygems.org'

# --- CORE REQUIREMENTS ---
gem 'rails',                          '4.1.6'
gem 'therubyracer',                   '0.12.1',       platforms: :ruby
gem 'turbolinks',                     '2.4.0'
gem 'jbuilder',                       '2.2.4'
gem 'unf',                            '0.1.4'
# gem 'asset_sync',                     '1.0.0'
gem 'mysql2',                         '0.3.16'
gem 'scrypt',                         '2.0.0'


# --- MODELS & CONTROLLERS ---
gem 'activerecord-tableless',         '1.3.4'
# gem 'paperclip',                      '4.2.0'
# gem 'paperclip-compression',          '0.3.6'
gem 'friendly_id',                    '5.0.4'
gem 'impressionist',                  '1.5.1'
gem 'will_paginate',                  '3.0.7'
gem 'sanitize',                       '3.0.2'
gem 'remotipart',                     '1.2.1'


# --- FORMATTING, STYLING, DISPLAY ---
gem 'haml',                           '4.0.5'
gem 'sass-rails',                     '4.0.3'
gem 'uglifier',                       '2.5.3'
gem 'coffee-rails',                   '4.1.0'
gem 'jquery-rails',                   '3.1.2'
gem 'jquery-ui-rails',                '5.0.2'
gem 'will_paginate-bootstrap',        '1.0.1'
gem 'bootstrap-sass',                 '3.2.0.2'
gem 'bourbon',                        '3.1.8'


# --- REDIS / SIDEKIQ ---
# gem 'sidekiq',                        '3.1.3'
# gem 'redis',                          '3.0.7'
# gem 'redis-rails',                    '4.0.0'


# --- FORM & RENDER HELPERS ---
gem 'simple_form',                      '~> 3.1.0.rc1',   github: 'plataformatec/simple_form',  branch: 'master'


# --- GENERAL HELPERS ---
gem 'rails-timeago',                  '2.11.1'
# gem 'zeroclipboard-rails',            '0.0.13'
gem 'momentjs-rails',                 '2.5.0'
gem 'chartkick',                      '1.3.2'
gem 'sitemap_generator',              '5.0.5',        require: false
gem 'split',                          '1.0.0'


# --- MONITORING / PERFORMANCE ---
gem 'rails-settings-cached',          '0.4.1'
gem 'airbrake',                       '4.1.0'
gem 'whenever',                       '0.9.4',        require: false


# --- OAUTH / APIS ---
# gem 'aws-sdk',                        '1.49.0'
gem 'github_api',                     '0.12.2'
gem 'twitter',                        '5.11.0'



# --- DEVELOPMENT & TEST ---

group :development do
  gem 'unicorn',                      '4.8.3'
  gem 'bullet',                       '4.14.0'

  # Capistrano deployment
  gem 'capistrano',                   '3.2.1'
  gem 'capistrano-rvm',               '0.1.2'
  gem 'capistrano-rails',             '1.1.2'
  gem 'capistrano-bundler',           '1.1.3'
  # gem 'capistrano-sidekiq',           '0.3.2'
  gem 'quiet_assets',                 '1.0.3'

  gem 'sinatra',                      '1.4.5',        require: false
  gem 'slim',                         '2.1.0'
end

group :test do
  gem 'capybara',                     '2.4.4'
  gem 'capybara-webkit',              '1.1.0'
  gem 'simplecov',                    '0.9.1',        require: false
  gem 'selenium-webdriver',           '2.43.0'
  gem 'sqlite3',                      '1.3.9'
end

group :development, :test do
  gem 'rspec-rails',                  '3.1.0'
  gem 'database_cleaner',             '1.3.0'
  gem 'ffaker',                       '1.25.0'
  gem 'factory_girl_rails',           '4.5.0'
end