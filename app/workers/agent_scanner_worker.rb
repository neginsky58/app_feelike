class AgentScannerWorker 
  include Sidekiq::Worker
  

  def perform
		Api::ModulesLoaders.scanYoutube('No Category','',5,lambda {})
		#Api::ModulesLoaders.scanItunes()
		#Api::ModulesLoaders.scanAmazon()
  end
end