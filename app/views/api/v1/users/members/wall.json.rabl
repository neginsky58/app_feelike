object @responseObject => :response
extends 'api/v1/base/index'
child :objectData => :data do |response|
  attributes :total,:items,:totalFolloing,:totalFollower,:fname,:lname,:image,:is_follow
end