begin
  require 'rubygems'
  source 'http://rubygems.org'

	#rest service post man file link http://www.getpostman.com/collections/f49469e85a89a209924f for checks
	gem 'rails', '3.2.13'

	# Bundle edge Rails instead:
	# gem 'rails', :git => 'git://github.com/rails/rails.git'
	gem 'pg'
	gem 'activerecord-postgresql-adapter'
	gem 'activerecord-postgres-hstore'
	gem 'activerecord-postgres-array'
	# Gems used only for assets and not required
	# in production environments by default.
	group :assets do
		gem "coffee-script", "~> 2.2.0"
	  gem 'sass-rails',   '~> 3.2.3'
	  #gem 'coffee-rails', '~> 3.2.1'
	  gem "requirejs-rails", "~> 0.9.0"
	  gem 'bootstrap-sass', '~> 2.2.2.0'
	  gem 'jquery-rails'
	  gem "jqueryui_rails", "~> 0.0.4"
	  gem 'underscore-rails'
	  gem 'underscore-string-rails'
		#gem 'coffee-rails', '~> 3.2.1'

		# See https://github.com/sstephenson/execjs#readme for more supported runtimes
		# gem 'therubyracer', :platforms => :ruby
		group :production do
			gem 'uglifier', '>= 1.0.3'
		end
	end

	group :development ,:localsivanlinux,:localsivanwindows , :staging , :prestaging do
		gem "binding_of_caller"
		gem "better_errors"
		# To use debugger
		gem 'pry'
		gem 'pry-remote'
		gem 'pry-nav' 
		gem 'debugger'
	end
	gem "rspec-rails", :group => [:test, :development,:localsivanlinux,:localsivanwindows]
	group :test do
	  gem "factory_girl_rails"
	  gem "capybara"
	  gem "guard-rspec"
	end
	gem 'jquery-rails'
	gem 'itunes-affiliate' , :git => 'https://github.com/iloveitaly/ruby-itunes-affiliate.git'
	#for enable s3 engin uncommit here
	gem 'aws-sdk'
	# To use ActiveModel has_secure_password
	gem 'bcrypt-ruby', '~> 3.0.0'

	gem "rest-client", "~> 1.6.7"
	#enable upload
	#gem "rmagick"
	gem 'fog'
	gem 'paperclip'
	# To use rabl templates for JSON
	gem 'rabl'
	gem 'yajl-ruby', :require => "yajl"
	#api ver
	gem 'versionist'
	gem 'kaminari'
	gem 'redis-rails' 
	gem "redis-store", "~> 1.1.3"
  gem 'devise'
  #gem 'sidekiq_mailer'
  gem 'tlsmail'
  gem 'cancan'
  gem 'rolify'
	gem 'cancan'
	gem 'oauth2'
	gem 'sidekiq'
	gem "koala", "~> 1.7.0rc1"
	#gem 'slim'
	#gem 'sinatra', '>= 1.3.0', :require => nil
	gem 'whenever', :require => false #how to use go here https://github.com/javan/whenever
	# Unicorn Web Server
	gem 'unicorn'
  group :production, :staging , :prestaging do
    #gem 'therubyracer'
		gem 'debugger-ruby_core_source'
    gem 'unicorn'
		gem 'push-core' 
		gem 'push-apns' 
		gem 'push-c2dm'
		gem 'push-gcm' 
  end
	# Deploy with Capistrano
	gem 'capistrano'
	# Capistrano RVM integration
	gem 'rubber'
	gem 'open4'
	# Deploy with Capistrano
	gem 'capistrano'
rescue LoadError => e
  $stderr.puts "Application requires Bundler. Please install it with `gem install bundler`. #{e.inspect}" 
  exit 1
end