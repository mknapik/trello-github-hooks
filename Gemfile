source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'devise'                    # for authorization
gem 'cancan'
gem 'sqlite3'
gem 'thin', require: false

gem 'jquery-rails'              # Use jquery as the JavaScript library
gem 'jquery-ui-rails'
gem 'coffee-rails'
gem 'turbolinks'                # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder', '~> 1.2'        # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'figaro'                    # used for keeping secret data private
gem 'rails_admin'
gem 'simple_form'

# assets
gem 'slim-rails'
gem 'less-rails'
gem 'sass-rails'
gem 'less-rails-bootstrap', '<3.0.0'
gem 'nprogress-rails'
gem 'libv8'
gem 'therubyracer'

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

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
gem 'debugger', group: [:development, :test]
