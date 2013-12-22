object @responseObject => :response
extends 'api/v1/base/index'
child :objectData => :data do |response|
	attributes :ue_id
end