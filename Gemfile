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
gem 'angular-rails-templates'
gem 'material_icons'
gem 'therubyracer' # javascript runtime
gem 'execjs' # javascript runtime

gem 'devise', :github => 'plataformatec/devise', :branch => 'master'
gem "rails-assets-angular-devise", :source => 'https://rails-assets.org'
gem 'ng-rails-csrf'
gem 'angularjs-rails-resource', '~> 2.0.0'

gem 'has_scope'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', :require => 'rack/cors'

gem 'coffee-rails'
gem 'sass-rails'
gem 'uglifier'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'jazz_fingers'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rails-footnotes'
  gem "parallel_tests"
  gem 'rb-inotify'
  gem 'guard-spring'
  gem 'faker'
  gem 'jasmine-rails'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-jasmine'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'better_errors'
  gem 'bullet'
  gem 'annotate'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano-bower',   require: false
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', :require => false
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'headless'
  gem 'fuubar'
  gem 'rspec-retry'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
