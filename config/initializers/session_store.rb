# Be sure to restart your server when you modify this file.

Feellike::Application.config.session_store :cookie_store, key: '_Feellike_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")

#Feellike::Application.config.session_store :redis_store , servers: [sprintf(RedisUri ,RedisAccessPoint['password'],RedisAccessPoint['host'],RedisAccessPoint['port'],RedisAccessPoint['db'],RedisAccessPoint['namespace'])]