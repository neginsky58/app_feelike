extends 'api/v1/base/index'
object @responseObject => :response
child :objectData => :data do |response|
	attributes :user_id , :update
end