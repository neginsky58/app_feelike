class Feelings < ActiveRecord::Base
	#default_scope order("sotyBy asc") 
  attr_accessible :id, :name , :hex #, :sotyBy

	#check for matchs in the db if true send alert 
	def self.isExists(id)
		if self.where(:id => id).size ==1 
			false
		else
			true
		end
	end
end
