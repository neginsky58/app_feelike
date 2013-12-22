module Api
	module Modules
		class ItunesScan < Adapters

			def initialize(providerCategory , term)
				super(Api::APIModules::Itunes,providerCategory , term)
				@currentItemsCount = 1 
				@items = Array.new 
			end

			protected
			def processMigrate(itemResponse) 
				unless itemResponse["profile"]["profile_itunes"].nil?
					#if have more then 1 category will add to all of them this item
					contentItem_itunes = ContentItemsItunes.new({
						artist_id: itemResponse["profile"]["profile_itunes"]["artist_id"].to_i,
						artist_name: itemResponse["profile"]["profile_itunes"]["artist_name"].to_s,
						artist_view_uri: itemResponse["profile"]["profile_itunes"]["artist_view_url"].to_s,
						artwork_uri: itemResponse["profile"]["profile_itunes"]["artwork_url"].to_s,
						collectionArt_name: itemResponse["profile"]["profile_itunes"]["collectionArt_name"].to_s,
						collection_id: itemResponse["profile"]["profile_itunes"]["duration"].to_i,
						collection_price: itemResponse["profile"]["profile_itunes"]["collection_price"].to_f,
						collection_view_uri: itemResponse["profile"]["profile_itunes"]["collection_view_url"].to_s,
						country: itemResponse["profile"]["profile_itunes"]["country"].to_s,
						currency: itemResponse["profile"]["profile_itunes"]["currency"].to_s,
						genre: itemResponse["profile"]["profile_itunes"]["primary_genre_name"].to_s,
						long_description: itemResponse["profile"]["profile_itunes"]["long_description"].to_s,
						preview_uri: itemResponse["profile"]["profile_itunes"]["preview_url"].to_s,
						track_id: itemResponse["profile"]["profile_itunes"]["track_id"].to_i,
						track_price: itemResponse["profile"]["profile_itunes"]["track_price"].to_f,
						track_time_millis: itemResponse["profile"]["profile_itunes"]["track_time_millis"].to_i,
						track_view_uri: itemResponse["profile"]["profile_itunes"]["track_view_url"].to_s,
						item_type: itemResponse["profile"]["profile_itunes"]["type"].to_s
					})
					contentItem = ContentItem.new({
						name: itemResponse['profile']["name"],
						description: itemResponse['profile']["description"],
						category_id: 2,
						views: 0,
						shares: 0,
						is_active: true,
						is_delete: false
					})
					contentItem_itunes.save!
					contentItem.profile_itunes_id = contentItem_itunes.id
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