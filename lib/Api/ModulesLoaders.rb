module Api
	class ModulesLoaders
		require 'Api/Modules/Adapters'
		require 'Api/Modules/YoutubeScan'
		require 'Api/Modules/AmazonScan'
		require 'Api/Modules/ItunesScan'
		include Singleton
		def initialize()
	  	logger.into "Api Loader Serivce start"
	  end
	  def self.scanYoutube(providerCategory , term,priority = 5,callback)
			driverYoutube = Api::Modules::YoutubeScan.new(providerCategory , term)
			driverYoutube.searchProvider(priority)
			driverYoutube.migrate(callback)
	  end
	  def self.scanItunes(providerCategory , term,priority = 5,callback)
			driverItunes = Api::Modules::ItunesScan.new(providerCategory , term)
			driverItunes.searchProvider(priority)
			driverItunes.migrate(callback)
	  end
	  def self.scanAmazon(providerCategory , term,priority = 5,callback)
			driverAmazon = Api::Modules::AmazonScan.new(providerCategory , term)
			driverAmazon.searchProvider(priority)
			driverAmazon.migrate(callback)
	  end
	end
end