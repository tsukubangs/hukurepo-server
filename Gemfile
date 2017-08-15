source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use sqlite3 as the database for Active Record
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# use for api
gem 'prmd'

# use serializer
gem 'active_model_serializers'
gem 'rack-json_schema'

# use for user devise
gem 'devise'

# use for photo uploader
gem 'carrierwave'
gem 'piet'
gem 'piet-binary'
gem 'mini_magick'

# use for enviroment value
gem 'dotenv-rails'

# use for slack notification
gem 'slack-api'

# use for sending mail
gem 'sendgrid-ruby'

# use for pagenation
gem 'kaminari'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'database_cleaner'
  gem 'autodoc'
  gem 'json_spec'
  gem 'rails-erd'
  gem 'guard'
  gem 'guard-rspec'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'sqlite3'
end

group :production do
  gem 'mysql2'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
