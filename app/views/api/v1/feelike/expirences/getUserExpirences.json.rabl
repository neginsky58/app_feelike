object @responseObject => :response
extends 'api/v1/base/index'
child :objectData => :data do |response|
	attributes :id , :name ,:user_id
end