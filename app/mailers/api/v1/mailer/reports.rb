class Api::V1::Mailer::Reports < ActionMailer::Base
  default from: "report@feelike.com"
  default :sender => 'report@feelike.com'
	def deliver_user_exp( exp_id , user_id ,  name)
		@subject = 'Report User Expriance, UE Name: %s (%d)' % [ name,exp_id]
		@recipients = "report@feelike.com"
		@sent_on = Time.now
		@title = 'Report User Expriance, UE Name: %s (%d)' % [ name,exp_id]
		@message = "Report User Expriance: <br /><ul><li> UE ID: %d </li><li>User ID: %d</li><li>UE Name: %s</li></ul>" % [exp_id , user_id ,  name] 
		@headers = {}
	end
	def deliver_user(user_id ,  name)
		@subject = 'Report User, User Name: %s (%d)' % [name ,user_id]
		@recipients = "report@feelike.com"
		@sent_on = Time.now
		@title = 'Report User, User Name: %s (%d)' % [ name ,user_id] 
		@message = "Report User : <br /><ul><li>User ID: %d</li><li>User Name: %s</li></ul>" % [ user_id ,  name] 
		@headers = {}
	end
	def deliver_feelike(item_id,user_id,feeling_id,ue_id, asset_id , content)
		@subject = 'Report Feelike,  %s(%d,%d,%d,%d)' % [content ,user_id,item_id,feeling_id,ue_id]
		@recipients = "report@feelike.com"
		@sent_on = Time.now
		@title = 'Report Feelike,  %s(%d,%d,%d,%d)' % [content ,user_id,item_id,feeling_id,ue_id]
		@message = "Report User : <br /><ul><li>User ID: %d</li><li>Item ID: %d</li><li>Feeling ID: %d</li><li>UE ID: %d</li><li>Asset ID: %d</li><li>Content: %s</li></ul>" % [ user_id ,item_id,feeling_id,ue_id,asset_id, content] 
		@headers = {}
	end
end
