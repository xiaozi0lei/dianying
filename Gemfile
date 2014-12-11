#source 'https://ruby.taobao.org'

source 'https://rubygems.org'

gem 'rails','~> 3.2.16'
gem 'rack', '~> 1.4.5'
gem 'strong_parameters'
# redcarpet engine for markdown markup
gem 'redcarpet'
# highlight code
gem 'pygments.rb'
# paginate 分页
gem 'will_paginate'
# tags for articles classification文章分类
gem 'acts-as-taggable-on'
# upload pictures and resize to 200x200
gem 'carrierwave'
# need ImageMagick-devel installed in the server, let's try
gem "rmagick"

# friendly URL format instead of the number id
gem 'friendly_id'
# help frienly ID to solve the chinese
#gem 'babosa'

# simple form with bootstrap easily
gem 'simple_form'

# comment notifications
gem 'mailboxer'

# full text-search
gem 'sunspot_rails'
gem 'sunspot_solr'

# translate chinese url to engilsh
gem 'stringex'

#group :production, :mysql do
#  gem 'mysql2'
#end

group :production, :postgresql do
  gem 'pg'
end

group :development, :test do
  # avoid the warning message, restrict the 4.x version
  gem 'minitest', '~> 4.7.5'
  gem 'thor', '= 0.14.6'
  # debug tool awesome
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rails'
  # integeration testing with rspec framework
  gem 'rspec-rails', '~> 3.0'
  # spring server to save the test time
  # gem 'spring'
  # gem 'spring-commands-rspec'
  # auto test tool
  #gem 'guard'
  gem 'guard-rspec'
  # run a server in the background, save the test rime. Same as spring.
  gem 'spork'
  # guard support spork
  gem 'guard-spork'
  gem 'childprocess'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
  # prepare data for testing
  gem 'factory_girl_rails'
end
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', :require => "bcrypt"

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# by me Guolei Sun
gem 'execjs'
