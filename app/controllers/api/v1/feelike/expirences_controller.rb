class Api::V1::Feelike::ExpirencesController < API::V1::BaseController
	prepend_before_filter :get_api_key
	before_filter :authenticate_user!
	skip_before_filter :verify_authenticity_token
  respond_to :json
  def get
    errors ||= Array.new
    if params[:ue_id].blank? && !UsersExprience.isExists(params[:ue_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      ueObj = UsersExprience.where({id: params[:ue_id].to_i}).first
      ue_p = UsersExprienceParticipants.where({user_exp_id:params[:ue_id].to_i})
      user_profiles = Array.new
      ue_p.each do |item|
        userProfile = UsersProfile.byUser(item.user_id).first
        imageObject = {
          id: -1,
          uri: ''
        }
        begin
          unless userProfile.image_id.nil?
            asset = Assets.where({id:userProfile.image_id}).first.asset.url(:small)
            imageObject[:id] = userProfile.image_id
            imageObject[:uri] = asset
          end
          objData = {
            fname: userProfile.fname,
            lname: userProfile.fname,
            image: imageObject,
            user_id: item.user_id
          }
          user_profiles.push(objData)
        rescue => e
          logger.error e
        end
      end
      is_private ||= false
      is_private = ueObj.is_private unless ueObj.is_private.nil?
      dataHash = OpenStruct.new({
        ue_id: ueObj.id,
        name: ueObj.name,
        content: ueObj.content,
        is_private: is_private,
        participants: user_profiles,
      })
      @responseObject = OpenStruct.new({
        status: true,
        errors: [],
        code: API_CODE_ERRORS['Services']['Global']['success'],
        objectData: dataHash,
        timestamp: (Date.new).to_time.to_i.abs
      })
      render :template => 'api/v1/feelike/expirences/get' ,:handlers => [:rabl],:formats => [:json]
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def getExpirenceCategories
    expCategories = UsersExprienceCategories.all()
    @responseObject = OpenStruct.new({
        status: true,
        errors: [],
        code: API_CODE_ERRORS['Services']['Global']['success'],
        objectData: expCategories
      })
      render :template => 'api/v1/feelike/expirences/categoires' ,:handlers => [:rabl],:formats => [:json]
  end
  
  def addParticipants 
    errors ||= Array.new
    if params[:users_array].blank?
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:ue_id].blank? && !UsersExprience.isExists(params[:ue_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      users_ids = params[:users_array].split(",").map { |s| s.to_i }
      users_ids = users_ids.each  do |user_id|
        unless User.isUserExistById(user_id)
          UsersExprienceParticipants.create({user_id:user_id , user_exp_id:params[:ue_id].to_i})
          Notifications.createNotification(user_id, params[:user].id, params[:ue_id].to_i,3)
        end
      end
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def destroyParticipants 
    errors ||= Array.new
    if params[:users_array].blank?
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:ue_id].blank? &&! UsersExprience.isExists(params[:ue_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      users_ids = params[:users_array].split(",").map { |s| s.to_i }
      users_ids = users_ids.each  do |user_id|
        unless User.isUserExistById(user_id)
          ue_p = UsersExprienceParticipants.where({user_id:user_id , user_exp_id:params[:ue_id].to_i})
          if ue_p.count != 0
            ue_p.first.destroy()
          end
        end
      end
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def getExpirenceProfile
    errors ||= Array.new
    if params[:ue_id].blank? && !UsersExprience.isExists(params[:ue_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:type].blank? 
      params[:type] = 'all'
    end
    if params[:page].blank? 
      params[:page] = 1
    end

    if errors.length == 0 
      ueObject = UsersExprience.where({id: params[:ue_id].to_i}).first
      data = ueObject.getExpienceByProfile(params[:type],params[:user].id,params[:page].to_i)
      @responseObject = OpenStruct.new({
        status: true,
        errors: [],
        code: API_CODE_ERRORS['Services']['Global']['success'],
        objectData: OpenStruct.new(data),
        timestamp: (Date.new).to_time.to_i.abs
      })

      render :template => 'api/v1/feelike/expirences/expirenceProfile' ,:handlers => [:rabl],:formats => [:json]
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def removeExpirence 
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
  def addFollowExpirence
    errors ||= Array.new
    if params[:ue_id].blank? &&UsersExprience.isExists( params[:ue_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      ue = UsersExprience.where({id:params[:ue_id].to_i}).first
      UsersExprienceFollowers.create({users_id: params[:user].id,users_expriences_id:params[:ue_id].to_i})
      Notifications.createNotification(ue.user_id, params[:user].id, params[:ue_id].to_i,4)
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def getExpirenceFollows
    if params[:user_id].blank? ||!User.isUserExistById( params[:user_id].to_i)
      params[:user_id] =  params[:user].id
    end
    if  params[:category_id].blank?  && params[:category_id].to_i != 0
      if UsersExprienceCategories.isExists( params[:category_id].to_i)
        params[:category_id] =  0
      end
    end
    if params[:page].blank? ||params[:page].is_int
      params[:page] = 1
    end
    if  params[:exp_search_name].blank?
      params[:exp_search_name] = ''
    end
    #users_following = UsersFollows.getExpienceByFollowing(params[:user_id].to_i)
    #user_id,users ,cat_id,exp_search_name,page
    #objectHash = UsersExprience.getExpienceByFollowers(params[:user].id,users_following,params[:category_id].to_i,params[:exp_search_name], params[:page].to_i)
    objectHash = UsersExprience.getExpienceByFollowing(params[:user].id,params[:category_id].to_i,params[:exp_search_name], params[:page].to_i)
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
    render :template => 'api/v1/feelike/expirences/list' ,:handlers => [:rabl],:formats => [:json]
  end

  def removeFollowExpirence
    errors ||= Array.new
    if params[:ue_id].blank? &&UsersExprience.isExists( params[:ue_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      ue_follow = UsersExprienceFollowers.where({users_id: params[:user].id,users_expriences_id:params[:ue_id].to_i})
      unless ue_follow.nil?
        ue_follow.first.destroy.save
      end
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def addBlankExpirence 
    uexpObj = UsersExprience.new({user_id: params[:user].id,content: '' ,name: ''})
    uexpObj.save
    dataHash = OpenStruct.new({
      ue_id: uexpObj.id
    })
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: dataHash,
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/expirences/addBlankExpirence' ,:handlers => [:rabl],:formats => [:json]
  end
  def updateExpirence
    errors ||= Array.new
    if params[:ue_id].blank? &&params[:ue_id] && UsersExprience.isExists(params[:ue_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:image_id].blank? 
      params[:image_id]=nil
    end
    if params[:name].blank?
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:content].blank?
      params[:content] = ''
    end
    if params[:is_private].blank?
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      ueObj = UsersExprience.where({id: params[:ue_id].to_i}).first
      ueObj.image_id = params[:image_id].to_i unless params[:image_id].nil?
      ueObj.content = params[:content]
      ueObj.name = params[:name]
      nameMatched = ueObj.name.split(" ")
      #we clear all matches
      matchCatg = UsersExprience2Categories.where({ue_id: ueObj.id})
      matchCatg.destroy() unless matchCatg.size == 0
      nameMatched.each do |item|
        UsersExprience2Categories.appendUE(ueObj.id,item)
      end
      ueObj.is_private = params[:is_private].to_boolean
      ueObj.save
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def getUserExpirences
    if params[:name].blank? || params[:name].length < 2 #make sure the input was not empty
      params[:name] = nil
    end
    data = UsersExprience.getExpienceByUser(params[:user].id,params[:name] )
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: data,
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/expirences/getUserExpirences' ,:handlers => [:rabl], :formats => [:json]
  end
  def deleteUserExpirence
    errors ||= Array.new
    if params[:ue_id].blank? &&params[:ue_id] && UsersExprience.isExists(params[:ue_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      ueObj = UsersExprience.where({id: params[:ue_id].to_i}).first
      ueObj.is_delete = true
      ueObj.is_active = false
      ueObj.save
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def send_report
    errors ||= Array.new
    if params[:ue_id].blank? &&params[:ue_id] && UsersExprience.isExists(params[:ue_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      ueObj = UsersExprience.where({id: params[:ue_id].to_i}).first
      Api::V1::Mailer::Reports.deliver_user_exp(ueObj.id, ueObj.user_id, ueObj.name).deliver
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def getAll
    if params[:page].blank? ||params[:page].is_int
      params[:page] = 1
    end
    ueItems = UsersExprience.getAll(params[:page].to_i)
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: ueItems,
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/expirences/list' ,:handlers => [:rabl],:formats => [:json]
  end
end
