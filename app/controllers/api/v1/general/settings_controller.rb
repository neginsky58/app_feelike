class Api::V1::General::SettingsController < API::V1::BaseController
  prepend_before_filter :get_api_key
  before_filter :authenticate_user!,except: [:get]
  before_filter :check_exist_setting ,except: [:new]
  before_filter :check_new_setting ,only: [:new]
  skip_before_filter :verify_authenticity_token
  respond_to :json
  def get
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: @setting
    })
    render :template => 'api/v1/general/settings/get' ,:handlers => [:rabl],:formats => [:json]
  end
  def new
    setting = Params.new({name: params[:key],value: params[:value]})
    setting.save!
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: setting,
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/general/settings/get' ,:handlers => [:rabl],:formats => [:json]
  end
  def update
    @setting.value = params[:value]
    @setting.save
    self.default_response
  end
  def destroy
    @setting.destroy.save
    self.default_response
  end
  private 
  def check_new_setting 
    errors ||= Array.new
    if params[:key].blank?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    pageIns = Params.where("name = ?" , params[:key]).size
    if pageIns != 0
      errors.push(I18n.t("errors.messages.general.settings.setting_existed"))
    end
    if params[:value].blank? 
      params[:value] = ""
    end
    if errors.length == 0 
      true
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def check_exist_setting
    errors ||= Array.new
    if params[:key].blank?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    @setting = Params.find_by_name(params[:key])
    if @setting.nil?
      errors.push(I18n.t("errors.messages.general.settings.setting_not_existed"))
    end
    if errors.length == 0 
      true
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
end
