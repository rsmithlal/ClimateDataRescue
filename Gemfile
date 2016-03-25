source 'https://rubygems.org'

gem 'rails', '4.2.0' #'3.2.16'

gem 'railties', '~> 4.2.0' #'3.2.16'

gem 'mysql2', '~> 0.3.20'

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'coffee-rails'
  #gem 'foundation-rails', '~> 6.1.1.3' #'~> 5.4.5.0'
  #gem 'foundation-icons-sass-rails'
  #See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '~> 2.7.2' #'>= 1.0.3'

#bootstrap stuff
gem 'sass-rails'
gem 'sprockets-rails'
gem 'bootstrap-sass'
gem 'autoprefixer-rails', '5.2.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  
    #gem "therubyracer"
    #gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
    #gem "twitter-bootstrap-rails"
end



#for user authentication
gem 'devise', '~> 3.5.4' #"3.2"
gem 'cancan', '~> 1.6.10'

#to handle .slim files
gem 'slim-rails', '~> 3.0.1' # view templates

#for forms
gem 'simple_form', '~> 3.2.1' #'2.1.3'
gem 'will_paginate', '3.1.0' #'~> 3.0.6'

#for attachments
gem 'paperclip', '4.3.2' #'~> 4.2'

# Support for tag inputs
gem 'select2-rails'

gem 'jbuilder'

gem "jquery-fileupload-rails"

gem 'rails-i18n' # translations
gem 'i18n-active_record',
      :git => 'git://github.com/svenfuchs/i18n-active_record.git',
      :tag => 'v0.1.0',
      :require => 'i18n/active_record'

# gem 'aws-sdk'
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
group :development do
  gem 'capistrano', '~> 3.4.0'#'~> 3.1'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler', '~> 1.1.4' #'~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1.6' #'~> 1.1'
  gem 'capistrano3-puma'
  
  gem 'execjs'
  #web server - better than WEBrick
  gem 'thin', '~>1.6.4' #'~> 1.6.3'
end

group :production do
  gem 'puma', '~> 2.15.3' #'2.12.3'
end

# To use debugger
# gem 'debugger'

