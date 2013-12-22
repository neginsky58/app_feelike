class Api::V1::Mailer::NotificationMailer < ActionMailer::Base
  default from: "feeds@feelike.com"
  default :sender => 'feeds@feelike.com'
	def deliver_feelike( recipient , fullName)
		@subject = 'User %s has post feelike from your feelike ' % [fullName]
		@recipients = recipient
		@sent_on = Time.now
		@User =fullName
		@headers = {}
		puts "Mail Sent to %s" % [@recipients]
		mail(:to => recipient, :subject => @subject) do |format|
      format.html { render 'api/v1/mailer/notification_mailer/deliver_feelike' }
    end
	end
	def deliver_fowllowing( recipient , fullName, byfullName)
		@subject = 'User %s is fowllowing you ' % [byfullName]
		@recipients = recipient
		@sent_on = Time.now
		@User =fullName
		@ByUser = byfullName
		
		@headers = {}
		puts "Mail Sent to %s" % [@recipients]
		mail(:to => recipient, :subject => @subject) do |format|
      format.html { render 'api/v1/mailer/notification_mailer/deliver_fowllowing' }
    end
	end
	def deliver_ue_p( recipient , fullName, byfullName)
		@subject = 'User %s is expirace fowllowing you ' % [byfullName]
		@recipients = recipient
		@sent_on = Time.now
		@User =fullName
		@ByUser = byfullName
		@headers = {}
		puts "Mail Sent to %s" % [@recipients]
		mail(:to => recipient, :subject => @subject) do |format|
      format.html { render 'api/v1/mailer/notification_mailer/deliver_ue_p' }
    end
	end
	def deliver_experience( recipient , fullName, byfullName)
		@subject = 'User %s is expirace p  on you ' % [byfullName]
		@recipients = recipient
		@sent_on = Time.now
		@User =fullName
		@ByUser = byfullName
		@headers = {}
		puts "Mail Sent to %s" % [@recipients]
		mail(:to => recipient, :subject => @subject) do |format|
      format.html { render 'api/v1/mailer/notification_mailer/deliver_experience' }
    end
	end
	def deliver_register(recipient ,fullName )

		@subject = 'User %s has register' % [fullName]
		@recipients = recipient
		@sent_on = Time.now
		@User =fullName
		@headers = {}
		puts "Mail Sent to %s" % [@recipients]
		mail(:to => recipient, :subject => @subject) do |format|
      format.html { render 'api/v1/mailer/notification_mailer/deliver_register' }
    end
	end
end
