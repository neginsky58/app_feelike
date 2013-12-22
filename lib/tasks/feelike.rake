namespace :feelike do
	desc "Cron task for feelike system that analyst the usercontentitem and give quick stats"
	task :analyst => :environment do
		StatsWorker.perform_async()
	end
end
