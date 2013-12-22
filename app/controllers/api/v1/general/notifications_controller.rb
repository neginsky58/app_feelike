class Api::V1::General::NotificationsController < API::V1::BaseController
  prepend_before_filter :get_api_key
  before_filter :authenticate_user! 
  def new 
    errors ||= Array.new
    if params[:ue_id].blank? && !UsersExprience.isExists(params[:ue_id].to_i)
      params[:ue_id] = 0
    end
    if params[:user_id].blank? || User.isUserExistById(params[:user_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:notification_status].blank? || NotificationsStatus.isExists(params[:notification_status].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      Notifications.createNotification(params[:user].id, params[:user_id].to_i, params[:ue_id].to_i,params[:notification_status].to_i)
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def getCount 
    totalCount = Notifications.where({is_sent: true ,is_read:false , user_id:params[:user].id}).size
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({
        total: totalCount
      }),
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/general/notifications/total' ,:handlers => [:rabl],:formats => [:json]
  end
	def getAll
    errors ||= Array.new
    if params[:page].blank? ||params[:page].is_int
      params[:page] = 0
    end

    if params[:page] == 0
      params[:page] = 1
    end

    if errors.length == 0 
      objectHash = Notifications.getNotifications(params[:user].id,params[:page] )
      @responseObject = OpenStruct.new({
        status: true,
        errors: [],
        code: API_CODE_ERRORS['Services']['Global']['success'],
        objectData: OpenStruct.new({
          items: objectHash[:items],
          total: objectHash[:total]
        }),
        timestamp: (Date.new).to_time.to_i.abs
      })
      render :template => 'api/v1/general/notifications/list' ,:handlers => [:rabl],:formats => [:json]
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
	end
end
