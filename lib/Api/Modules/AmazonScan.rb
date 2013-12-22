module Api
	module Modules
		class AmazonScan < Adapters

			def initialize(providerCategory , term)
				super(Api::APIModules::Amazon,providerCategory , term)
				@currentItemsCount = 1 
				@items = Array.new 
			end

			protected
			def processMigrate(itemResponse) 
				unless itemResponse["profile"]["profile_amazon"].nil?						
					binding.pry
					unless itemResponse["profile"]["profile_amazon"]["title"].to_s.empty? 
						#if have more then 1 category will add to all of them this item
							binding.pry
							contentItem_amazon = ContentItemsAmazon.new({
								uri: itemResponse["profile"]["profile_amazon"]["page_uri"].to_s,
								item_id: itemResponse["profile"]["profile_amazon"]["item_id"].to_i,
								authors: [itemResponse["profile"]["profile_amazon"]["author"]],
								ean: itemResponse["profile"]["profile_amazon"]["ean"].to_s,
								edition: itemResponse["profile"]["profile_amazon"]["edition"].to_i,
								isbn: itemResponse["profile"]["profile_amazon"]["isbn"].to_s,
								images: itemResponse["profile"]["profile_amazon"]["images"],
								number_of_pages: itemResponse["profile"]["profile_amazon"]["number_of_pages"].to_i,
								title: itemResponse["profile"]["profile_amazon"]["title"].to_s,
								studio: itemResponse["profile"]["profile_amazon"]["studio"].to_s,
								manufacturer: itemResponse["profile"]["profile_amazon"]["manufacturer"].to_s,
								publish_date: itemResponse["profile"]["profile_amazon"]["publish_date"].to_s 
							})
							contentItem = ContentItem.new({
								name: itemResponse['profile']["name"],
								description: itemResponse['profile']["description"],
								category_id: 3,
								views: 0,
								shares: 0,
								is_active: true,
								is_delete: false
							})
							contentItem_amazon.save!
							contentItem.profile_amazon_id = contentItem_amazon.id
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
end