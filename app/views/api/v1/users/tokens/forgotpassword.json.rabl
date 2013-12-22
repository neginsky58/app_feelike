
object @responseObject => :response
extends 'api/v1/base/index'
child :objectData => :data do |response|
	attributes :is_email_exist
end