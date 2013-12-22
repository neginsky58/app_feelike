object @responseObject => :response
extends 'api/v1/base/index'
child :objectData => :data do |response|
	attributes :feelike_status, :follows_status, :experience_status , :experience_p_status ,:is_private
end 