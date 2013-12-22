object @responseObject => :response
extends 'api/v1/base/index'
child :objectData => :data do |response|
	attributes :id , :email , :fname , :lname , :gender , :image_id ,:bio 
end