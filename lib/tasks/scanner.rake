namespace :scanner do
	desc "Scenner for stats items on the agent system"
	task :low => :environment do
		AgentScannerWorker.perform_async()
	end
end
