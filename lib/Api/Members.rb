
module Api
	class Members
		include Singleton

		#will do a check on the data that user sent for make a register of an new user
		def self.checkRegisterParams (data = {}) 
			errors ||= Array.new
			if data[:email].to_s.empty?
				errors.push( {error: true , message: I18n.t("errors.messages.users.register_email")}) unless data[:email].to_s.is_email
			end
			if data[:password].to_s.empty? || data[:password].to_s.length <= 5 || data[:password].to_s.length >= 15  || data[:password] != data[:password_confirmation]
				errors.push({error: true , message: I18n.t("errors.messages.users.register_password")} )
			end
			if data[:fname].to_s.empty? || data[:fname].to_s.length <= 1
				errors.push( {error: true , message: I18n.t("errors.messages.users.register_fname")} )
			end
			if data[:lname].to_s.empty? || data[:lname].to_s.length <= 1
				errors.push({error: true , message: I18n.t("errors.messages.users.register_lname")} )
			end
			if data[:bdate].to_s.empty? || data[:bdate].to_s.is_date?
				errors.push({error: true , message: I18n.t("errors.messages.users.register_bdate")} )
			end
			if data[:gender].to_s.length != 1
					if data[:gender].to_s.downcase != 'm' &&data[:gender].to_s.downcase != 'f'
						#errors.push ({error: true , message: I18n.t("errors.messages.users.register_gender")} )
					end
			end
			unless data[:familyStatus].to_s.empty? == false
				#errors.push ({error: true , message: I18n.t("errors.messages.users.register_familyStatus")})
			end
			data[:bio] = '' unless data[:bio].to_s.empty? == false
			
			errors
		end
		#will do a check on the data that user sent for make a register of an new user
		def self.checkProfileParams (data = {}) 
			errors ||= Array.new
			if data[:fname].to_s.empty? || data[:fname].to_s.length <= 1
				errors.push({error: true , message: I18n.t("errors.messages.users.profile_fname")} )
			end
			if data[:lname].to_s.empty? || data[:lname].to_s.length <= 1
				errors.push({error: true , message: I18n.t("errors.messages.users.profile_lname")} )
			end
			if data[:bdate].to_s.empty? || data[:bdate].to_s.is_date?
				errors.push({error: true , message: I18n.t("errors.messages.users.profile_bdate")} )
			end
			if data[:gender].to_s.length != 1
					if data[:gender].to_s.downcase != 'm' &&data[:gender].to_s.downcase != 'f'
						#errors.push ({error: true , message: I18n.t("errors.messages.users.profile_gender")} )
					end
			end
			unless data[:familyStatus].to_s.empty? == false
				#errors.push ({error: true , message: I18n.t("errors.messages.users.profile_familyStatus")})
			end
			data[:bio] = '' unless data[:bio].to_s.empty? == false
			
			errors
		end

	end
end