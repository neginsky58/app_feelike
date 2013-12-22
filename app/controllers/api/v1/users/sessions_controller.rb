class Api::V1::Users::SessionsController < Devise::SessionsController
	prepend_before_filter :get_api_key
	before_filter :authenticate_user!
	#here we will create a new session as well make sure that the call come from  
	def create
        build_resource
        resource = User.find_for_database_authentication(:email => params[:email])
        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:password])
	        resource.ensure_authentication_token!  #make sure the user has a token generated
	        render :json => { :authentication_token => resource.authentication_token, :user_id => resource.id }, :status => :created
	        return
	    end
	end
	#session is deleted
	def destroy
	    # expire auth token
	    @user=User.where(:authentication_token=>params[:auth_token]).first
	    @user.reset_authentication_token!
	    render :json => { :message => ["Session deleted."] },  :success => true, :status => :ok
	end
	#kill the request from the system
	def invalid_login_attempt
	    warden.custom_failure!
	    render :json => { :errors => ["Invalid email or password."] },  :success => false, :status => :unauthorized
	end
  private
  #check if keys existed
  def get_api_key
  	#we search for the keys if existed
    if api_key = params[:api_key].blank? && request.headers["X-API-KEY"] && request.headers["EVN-API-KEY"]
    	if Rails.env.development?#we on diffrent place and for at we need make sure header X-API-KEY been set with currect key
	    	if request.headers["EVN-API-KEY"] = APP_CONFIG['API_Key']
	      		params[:api_key] = api_key
	      	end
	    else
	      	params[:api_key] = api_key #we on development so we do not need make sure that header has X-API-KEY in requests
	    end 
    end
  end
end