# Load the rails application
require File.expand_path('../application', __FILE__)

require 'active_support'
require 'utils/ar_hashing'
require 'aws/s3'

RedisAccessPoint = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]#will load the api login info
RedisUri = 'redis://:%s@%s:%s/%s/%s'
AWS::S3::DEFAULT_HOST = "s3-eu-west-1.amazonaws.com"
class ActiveRecord::Associations::AssociationCollection
  include ActiveRecordHashing
end
# Initialize the rails application
Feellike::Application.initialize!