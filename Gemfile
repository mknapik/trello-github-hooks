source 'https://rubygems.org'

ruby '2.0.0'

gem 'thin', require: false

gem 'rails', '~> 4.0.0'
gem 'devise'                    # for authentication
gem 'cancan'                    # for authorization
gem 'pg'

gem 'jquery-rails'              # Use jquery as the JavaScript library
gem 'jquery-ui-rails'
gem 'coffee-rails'
gem 'turbolinks'                # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder', '~> 1.2'        # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem 'rails_admin'
gem 'simple_form'
gem 'httparty'

# assets
gem 'slim-rails'
gem 'less-rails'
gem 'sass-rails'
gem 'less-rails-bootstrap', '<3.0.0'
gem 'uglifier'

gem 'nprogress-rails'

# Heroku suggests that these gems aren't necessary, but they're required to compile less assets on deploy.
gem 'therubyracer', platforms: :ruby
gem 'libv8', '~> 3.11.8'
gem 'rails_12factor', group: :production # required by heroku for Rails 4.0

group :test, :development do
  gem 'quiet_assets'
# guard
  gem 'guard'              # automatically run various tasks depending on file changes
  gem 'guard-bundler'      # runs `bundle install` on Gemfile changes
  gem 'guard-annotate'     # annotates model classes on schema changes
end

group :doc do
  gem 'sdoc', require: false    # bundle exec rake doc:rails generates the API under doc/api.
end

group :development do
  gem 'rails-erd'          # generates ERD from model (`rake erd`)
  gem 'ruby-graphviz'      # for state_machine graphs

  gem 'pry-rails'          # (more than) an IRB replacement
  gem 'rack-mini-profiler' # displays profiler in left upper corner
  gem 'foreman'
  gem 'better_errors'      # shows verbose error messages if action fails
  gem 'binding_of_caller'  # provides additional info for better_errors
  gem 'meta_request'       # for Chrome RailsPanel Extension

# guard
  gem 'guard-rspec'
  gem 'guard-livereload'   # reloads the browser after each change (browser plugin is required)
  gem 'rb-fsevent'
  gem 'libnotify'          # for guard notification

  gem 'spring'
end

# Use debugger
gem 'debugger', group: [:development, :test]
