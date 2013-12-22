class API::V1::BaseController < ApplicationController
	include Api
	respond_to :json
	rescue_from Timeout::Error, :with => :rescue_from_timeout


	protected
  def rescue_from_timeout(exception)
  	render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['timeout'],I18n.t("errors.messages.api_access"), [I18n.t("errors.messages.request_timeout")]).to_json
  end
	#check just if come from evnirment 
	def get_evn_api_key
		#binding.pry
		session[:user] = nil
    if request.headers["ENVAPIKEY"] && request.headers["ENVAPIKEY"] == APP_CONFIG['API_Key'] 
    	params[:env_api_key] = request.headers["ENVAPIKEY"]
  	else 
	  	token_error
  	end
	end
	def get_cron_api_key
		#binding.pry
		#
		session[:user] = nil
    if request.headers["ENVAPIKEY"] && request.headers["ENVAPIKEY"] == APP_CONFIG['API_Key'] 
    	params[:env_api_key] = request.headers["ENVAPIKEY"]
	    if request.headers["XCRONAPIKEY"] && request.headers["XCRONAPIKEY"] == APP_CONFIG['API_CRON_Key'] 
	    	params[:cron_api_key] = request.headers["XCRONAPIKEY"]
	    else
	    	token_error
	    end
  	else 
	  		token_error
  	end
	end
	def default_response
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: nil,
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/base/empty' ,:handlers => [:rabl],:formats => [:json]
	end
	#check if keys existed
	def get_api_key
		#we search for the keys if existed
		#binding.pry
		if request.headers["XAPIKEY"]
	    if request.headers["ENVAPIKEY"] && request.headers["ENVAPIKEY"] == APP_CONFIG['API_Key'] 
	    	api_key =request.headers["XAPIKEY"]
	    	env_api_key = request.headers["ENVAPIKEY"]
	    	if api_key.empty?
		    	reset_session #kill session ite hacker attemted
		    	token_error
	    	else
		    	@user=User.where({authentication_token: api_key}).first
			    if @user.nil?
			    	reset_session #kill session ite hacker attemted
			    	login_token_error
			    else
			    	session[:user] = @user
			    	params[:user] = @user
			    	params[:env_api_key] = env_api_key
			    	params[:api_key] = api_key #we on development so we do not need make sure that header has X-API-KEY in requests
			    end
	    	end
    	else 
		    	reset_session #kill session ite hacker attemted
		    	token_error
    	end
    else
    	token_error
    end
	end
  def method_missing (method_name)  
  	logger.error 'No Method Found %s ' %[method_name]
  	render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['unkowns'],I18n.t("errors.messages.no_found"), [I18n.t("errors.messages.no_found")]).to_json
  end  
	private 
	def token_error
		render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['api_key_invalid'],I18n.t("errors.messages.api_issue"), [I18n.t("errors.messages.api_key_invalid")]).to_json
	end
	def login_token_error
		render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Member']['login_error'],I18n.t("errors.messages.api_access"), [I18n.t("errors.messages.api_access")]).to_json
	end
end