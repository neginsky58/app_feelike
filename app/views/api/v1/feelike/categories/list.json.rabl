object @responseObject => :response
extends 'api/v1/base/index'
child :objectData => :data do |response|
	child response.items => :items do |item|
		attributes :id, :name , :asset_uri
	end
	attributes :total
end