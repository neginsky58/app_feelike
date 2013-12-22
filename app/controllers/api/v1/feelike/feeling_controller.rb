class Api::V1::Feelike::FeelingController < API::V1::BaseController
  prepend_before_filter :get_api_key, except: [ :getAll ]
  prepend_before_filter :get_evn_api_key , only: [:getAll]
  before_filter :authenticate_user! ,except: [:getAll]
  skip_before_filter :verify_authenticity_token,except: [:getAll]
  respond_to :json
  def getAll
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: Feelings.all,
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/feeling/list' ,:handlers => [:rabl], :formats => [:json]
  end
  def new
    errors ||= Array.new
    if params[:name].blank?
      errors.push(I18n.t("errors.messages.feelike.input_string_empty"))
    end
    if params[:hex].blank? 
      errors.push(I18n.t("errors.messages.feelike.input_string_empty"))
    end
    if errors.length == 0 
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def update
    errors ||= Array.new
    if params[:id].blank? ||params[:id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:name].blank?
      errors.push(I18n.t("errors.messages.feelike.input_string_empty"))
    end
    if errors.length == 0 
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def destroy
    errors ||= Array.new
    if params[:id].blank? ||params[:id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
end