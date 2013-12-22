object @responseObject => :response
extends 'api/v1/base/index'
child :data => :Params do
	attributes :id , :name 
end 