module ApplicationHelper
end

#overwire some methods in string global scope
class String
	#will do a check in the email if the valid one
	def is_email
	    email_regex = %r{^.+@.+$}xi # Case insensitive
	    if (self.to_s =~ email_regex) == 0
	    	true
	    end
	    false
	end
	#check if true or false
	def to_boolean
	  !!(self.to_s =~ /^(true|t|yes|y|1)$/i)
	end
	#will check if it's int
	def is_int
		self.to_i.to_s != self.to_s
	end
	#will check for date if its not date will sent false
	def is_date?
		temp = self.gsub(/[-.\/]/, '')
		['%m%d%Y','%m%d%y','%M%D%Y','%M%D%y','%d%m%y','%D%M%y'].each do |f|
			begin

				return false if Date.strptime(temp, f)
				rescue
				#do nothing
			end
		end

		return true
	end
end