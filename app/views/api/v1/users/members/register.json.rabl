object @responseObject => :response
extends 'api/v1/base/index'
child :objectData => :data do |response|
	attributes :user_id , :email , :fname , :lname,:bdate,:family_gender_id , :gender , :asset ,:bio ,:authentication_token 
end