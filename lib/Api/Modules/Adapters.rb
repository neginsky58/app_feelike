module Api
	module Modules
		class Adapters
			def initialize(providerName , providerCategory , term)
				@providerName = providerName
				@providerCategory = providerCategory
				@searchTerm = term.downcase
				@isLive = false
				@search_provider_key_format = "provider_%s_uri"
				@searchPriority = 5
				@responseData = Array.new
			end
			def searchProvider(priority = 5)
				@searchPriority = priority
				if priority == 10
					@isLive = true
				end
				unless @isLive 
					@search_provider_uri = sprintf(APP_CONFIG["Agent"]["Uri"],'items/feed')
				else
					@search_provider_uri = sprintf(APP_CONFIG["Agent"]["Uri"],'items/feed/live')
				end
				api_agent_version = APP_CONFIG["Agent"]["Version"]
				api_agent_evt_key = APP_CONFIG["Agent"]["API_KEY"]
				api_agent_cron_key = APP_CONFIG["Agent"]["API_CRON_Key"]
				if @search_provider_uri != "" 
		      API_LOOGER.info "Scan API" 

       		RestClient.open_timeout = 90000000
					RestClient.timeout = 90000000
					@matchedCategories = Categories2ProviderCategories.by_provider(@providerName, @providerCategory)
					responseHandler = Proc.new {|response, request, result|
						responseObject = ActiveSupport::JSON.decode(response)
		      	API_LOOGER.info responseObject
						prossesResponse(responseObject, request, result) if response.code && response.code == 200
					}
					RestClient.post( @search_provider_uri,{
											:provider => @providerName, 
											:providerCategory => @providerCategory, 
											:term => @searchTerm
										}, {
						        	:XAPI => api_agent_version , 
							        :ENVAPIKEY => api_agent_evt_key , 
							        :XCRONAPIKEY => api_agent_cron_key ,
							        :content_type => :json, 
							        :accept => :json
							      },&responseHandler)
				end
			end
			def migrate(callback)
				@callback = callback
				migrateResponse {|item| processMigrate(item)}
			end
			protected

			def migrateResponse
				@responseData.each do |item|
					yield item
				end
			end
			private 
			def prossesResponse(response, request, result)
				if response["code"] == 200 && response["status"]
					@totalItemsFound = response["data"].count
					API_LOOGER.info "Total Items Found %d" % [response["data"].length]
					response["data"].each{ |item| @responseData.push(item)}
				end
			end
			

		end
	end
end