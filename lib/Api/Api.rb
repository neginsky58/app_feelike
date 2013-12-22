require 'Api/Members'
module Api
	class Init
		include Singleton
		def initialize()
	  end
		#will give error json (its not part of the templates)
		def self.ShowErrorJson(codeError = 404,message = "unknown error", error_messages = ['unknown error'])
			errorObject = {
				status: false,
				message: message,
				errors:[],
				code: codeError,
				data:[],
        timestamp: (Date.new).to_time.to_i.abs
			}
			errors ||=  Array.new()
			error_messages.each { |message| errors.push( {error: true , message:message})}
			errorObject[:errors] =  errors
			errorObject
		end
		def self.ModulesLoaders 
		end
	  def self.MembersControl
			Api::Members
		end
	end

	module APIModules 
		Youtube = 'youtube'
		Itunes = 'itunes'
		Amazon = 'amazon'
	end
end