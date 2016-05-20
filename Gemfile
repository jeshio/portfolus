source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.rc1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'activerecord-import'
gem 'responders'
gem 'has_scope'
#gem 'draper'
gem "autoprefixer-rails"
gem 'email_validator'
gem 'sprockets'
gem 'sprockets-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'angular-rails-templates'
gem 'material_icons'

gem 'devise', :github => 'plataformatec/devise', :branch => 'master'
gem "rails-assets-angular-devise", :source => 'https://rails-assets.org'
gem 'ng-rails-csrf'
gem 'angularjs-rails-resource', '~> 2.0.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'jazz_fingers'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'bullet'
  gem 'rails-footnotes'
  gem "parallel_tests"
  gem 'rb-inotify'
  gem 'guard-spring'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'annotate'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'rspec', github: 'rspec/rspec'
  gem 'rspec-mocks', github: 'rspec/rspec-mocks'
  gem 'rspec-expectations', github: 'rspec/rspec-expectations'
  gem 'rspec-support', github: 'rspec/rspec-support'
  gem 'rspec-core', github: 'rspec/rspec-core'
  gem 'rspec-rails', github: 'rspec/rspec-rails'
  gem 'factory_girl_rails', :require => false
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'headless'
  gem 'fuubar'
  gem 'rspec-retry'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
  gem 'faker'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
