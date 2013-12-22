class Api::V1::Users::TokensController  < API::V1::BaseController
  prepend_before_filter :get_evn_api_key , only: [:create,:connectViaSocal]
  prepend_before_filter :get_api_key, except: [ :create ,:connectViaSocal]
  before_filter :authenticate_user!,  except: [ :create,:connectViaSocal ]
	skip_before_filter :verify_authenticity_token, except: [ :create ,:connectViaSocal]
  respond_to :json
  #will create the login as well will do the token gen for that user
  def create
    errors ||= Array.new
    email = params[:email]
    password = params[:password]
    if params[:mobileToken].blank?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    if params[:email].blank?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    if params[:password].blank?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    if errors.length == 0 
      if session[:user].nil?
        if email.nil? or password.nil? 
          render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Member']['login_error'],I18n.t("errors.messages.users.login_error"), [I18n.t("errors.messages.users.login_noinput")]).to_json
          return
        end
        
        @user=User.find_by_email(email.downcase)
        
        if @user.nil?
          logger.info("User #{email} failed signin, user cannot be found.")
          render  :json=> Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Member']['login_error'],I18n.t("errors.messages.users.login_error"), [I18n.t("errors.messages.users.login_error")]).to_json
          return
        end
        
        if not @user.valid_password?(password) 
          logger.info("User #{email} failed signin, password \"#{password}\" is invalid")
          render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Member']['login_error'],I18n.t("errors.messages.users.login_error"), [I18n.t("errors.messages.users.login_error")]).to_json
        else
          @user.ensure_authentication_token
          @user.after_database_authentication
          @user.save!
          session[:user]=@user
          userSettingObj = UsersSettings.byUser(@user.id).first
          userSettingObj.mobile_token = params[:mobileToken]
          userSettingObj.save
          @responseObject = OpenStruct.new({
            status: true,
            errors: [],
            code: API_CODE_ERRORS['Services']['Global']['success'],
            objectData: OpenStruct.new(User.getFullUserData(@user.id)),
            timestamp: (Date.new).to_time.to_i.abs
          })
  				render :template => 'api/v1/users/tokens/create' ,:handlers => [:rabl],:formats => [:json]
        end
      else
        render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Member']['login_error'],I18n.t("errors.messages.users.login_error"), [I18n.t("errors.messages.users.login_existed")]).to_json
      end
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.input_error"), errors).to_json
    end
  end
  
  def connectViaSocal
    errors ||= Array.new
    if params[:type] != 'facebook' && params[:type] != 'twitter'
      errors.push(I18n.t("errors.messages.socal_invaild"))
    end
    if params[:id].blank?
      params[:id] = 0
    end
    if params[:token].blank?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    if params[:mobileToken].blank?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end

    if errors.length == 0 
      userObj = User.locateSocalToken(params[:type] ,params[:token])
      unless userObj.nil?
        @user=userObj
        @user.ensure_authentication_token
        
        @user = User.find_by_authentication_token(@user.authentication_token)

        @user.save!
        session[:user]=@user
        userSettingObj = UsersSettings.byUser(@user.id).first
        userSettingObj.mobile_token = params[:mobileToken]
        userSettingObj.save
        @responseObject = OpenStruct.new({
          status: true,
          errors: [],
          code: API_CODE_ERRORS['Services']['Global']['success'],
          objectData: OpenStruct.new(User.getFullUserData(@user.id)),
          timestamp: (Date.new).to_time.to_i.abs
        })
        render :template => 'api/v1/users/tokens/create' ,:handlers => [:rabl],:formats => [:json]
      else
        errors.push(I18n.t("errors.messages.socal_token_invaild"))
        render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Member']['login_error'],I18n.t("errors.messages.input_error"), errors).to_json
      end
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.input_error"), errors).to_json
    end
  end
  #will kill the token
  def destroy
    logger.error(params)
    @user=User.find_by_authentication_token(params[:api_key])
    if @user.nil?
      logger.info("Token not found.")
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Member']['login_error'],I18n.t("errors.messages.users.login_error"), [I18n.t("errors.messages.token_invaild")]).to_json
    else
      #let remove active token
      @user.reset_authentication_token!
      @user.save!
      reset_session #remove all session params for its logout request and no data is needed after logout
      self.default_response
    end
  end  
  def forgotPassword
    errors ||= Array.new
    email = params[:email]
    if params[:email].blank?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    if errors.length == 0 
      @user=User.find_by_email(email.downcase)
      @user.send_password_reset if @user
      @responseObject = OpenStruct.new({
        status: true,
        errors: [],
        code: API_CODE_ERRORS['Services']['Global']['success'],
        objectData: OpenStruct.new({
          is_email_exist: !@user.nil?
        }),
        timestamp: (Date.new).to_time.to_i.abs
      })
      render :template => 'api/v1/users/tokens/forgotpassword' ,:handlers => [:rabl],:formats => [:json]
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.input_error"), errors).to_json
    end
  end
end