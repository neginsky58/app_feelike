class Api::V1::General::AgentControlController < API::V1::BaseController
	before_filter :get_cron_api_key
	def updateAgeRange
		ageRangeResponseObject = ActiveSupport::JSON.decode(params[:ranges])
		ageRangeResponseObject.each do |item|
			min = item['min']
			max = item['max']
			#is_removed = item.is_removed
			hashAgeRange = {:high=> max , :low=> min}
			rangedObject = AgeRanges.where(hashAgeRange)
			AgeRanges.create(hashAgeRange) unless rangedObject.size != 0
		end
		self.default_response
	end
end