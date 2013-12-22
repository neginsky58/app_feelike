#require 'apn_on_rails'
if Object.const_defined?('Push')
	ssl_apn_path = File.join(Rails.root, 'config','ssl', Rails.env+'.pem')
	puts "Ssl Path For Push System %s" % [ssl_apn_path]
	Push::ConfigurationApns.create(app: 'feelike_applciation', connections: 2, enabled: true,
			certificate_password: 'avishai',
	    certificate: File.read(ssl_apn_path),
	    feedback_poll: 60,
	    sandbox: false)
	Push::ConfigurationC2dm.create(app: 'app_name', connections: 2, enabled: false,
	    email: '<email address here>',
	    password: '<password here>')  
	    Push::ConfigurationGcm.create(app: 'app_name', connections: 2, enabled: false,
	    key: '<api key here>')  
end
#APN_APP = APN::App.new
#APN_APP.apn_dev_cert = ssl_apn_path
#APN_APP.save
#APN_Application =  APN::App.create(:apn_dev_cert => ssl_path,:apn_prod_cert => ssl_path)
