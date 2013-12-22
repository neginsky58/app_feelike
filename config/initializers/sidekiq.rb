Sidekiq.configure_server do |config|
 config.redis = {
 	:size => 25, 
 	:url => sprintf(RedisUri,RedisAccessPoint['password'],RedisAccessPoint['host'],RedisAccessPoint['port'],RedisAccessPoint['db'], RedisAccessPoint['namespace'])
 }
end

# When in Unicorn, this block needs to go in unicorn's `after_fork` callback:
Sidekiq.configure_client do |config|
  config.redis = {
  	:size => 25, 
 		:url => sprintf(RedisUri,RedisAccessPoint['password'],RedisAccessPoint['host'],RedisAccessPoint['port'],RedisAccessPoint['db'], RedisAccessPoint['namespace'])
  }
end