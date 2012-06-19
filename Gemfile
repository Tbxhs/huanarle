# source 'http://ruby.taobao.org'
source 'http://rubygems.org'

gem 'rails', '3.2.3'
# gem 'mysql2'

group :production do
  gem 'pg'
end
group :development, :test do
  gem 'mysql2'
end

# Server
gem 'thin'

# YAML 配置信息
gem 'settingslogic', '~> 2.0.6'

# 加密处理
gem 'bcrypt-ruby', '~> 3.0.0'

# 分页
gem 'will_paginate', '~> 3.0'

# 上传
gem 'carrierwave', '~> 0.6.2'
gem 'mini_magick'

# 又拍云存储
gem 'rest-client'
gem 'carrierwave-upyun'

# 第三方认证
gem 'omniauth', '~> 1.1.0'
gem 'omniauth-oauth2', '~> 1.0.2'

# HTTP Client
gem 'faraday', '~> 0.8.0'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Haml 模版
gem 'haml'
gem 'haml-rails'
