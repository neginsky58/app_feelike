module Api
	module Modules
		class YoutubeScan < Adapters

			def initialize(providerCategory , term)
				super(Api::APIModules::Youtube,providerCategory , term)
				@currentItemsCount = 1 
				@items = Array.new 
			end

			protected
			def processMigrate(itemResponse) 
				unless itemResponse["profile"]["profile_youtube"].nil?
					#if have more then 1 category will add to all of them this item

					contentItem_youtube = ContentItemsYoutube.new({
						embed_uri: itemResponse["profile"]["profile_youtube"]["embed_uri"],
						youtube_id: itemResponse["profile"]["profile_youtube"]["youtube_id"],
						mobile_uri: itemResponse["profile"]["profile_youtube"]["mobile_uri"],
						image_uri: itemResponse["profile"]["profile_youtube"]["image_uri"],
						author: itemResponse["profile"]["profile_youtube"]["author"],
						duration: itemResponse["profile"]["profile_youtube"]["duration"].to_i
					})
					contentItem = ContentItem.new({
						name: itemResponse['profile']["name"],
						description: itemResponse['profile']["description"],
						category_id: 1,
						views: 0,
						shares: 0,
						is_active: true,
						is_delete: false
					})
					contentItem_youtube.save!
					contentItem.profile_youtube_id = contentItem_youtube.id
					contentItem.save!
					#API_LOOGER.info contentItem
					@currentItemsCount.next
					lastItem = @responseData.last()
					if @totalItemsFound == @currentItemsCount
						term = "%#{params[:term]}%"
						@callback.call(1,term)
					end
				end
			end
		end
	end
end