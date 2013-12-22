class Backend::MainController < ApplicationController
	layout 'backendClientside'
	def getLocalization() 
		params[:lang] ||= 'en'
		path = Rails.root.join("lib/clientSettings/localization",params[:lang],"lang.json")
		@@data = File.read(path)
		render :json => @@data
	end 
	def getConfig() 
		path = Rails.root.join("lib/clientSettings/configs",params[:section]+".json")
		@@data = File.read(path)
		render :json => @@data
	end 
	def index
		render :template => 'backend/main/index'
	end
end
