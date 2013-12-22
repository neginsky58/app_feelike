class Api::V1::Users::MembersController < API::V1::BaseController
  prepend_before_filter :get_evn_api_key , only: [:register,:getFamilyStatus]
	prepend_before_filter :get_api_key, except: [ :register,:getFamilyStatus ]
	before_filter :authenticate_user! ,except: [:register,:getFamilyStatus]
	skip_before_filter :verify_authenticity_token, only: [:register,:getFamilyStatus]
	#testing Params
	#will get all family status user can have
	def getFamilyStatus
		@responseObject = OpenStruct.new({
			status: true,
			errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
			objectData: FamilyGender.find(:all, :order => 'name DESC')
		})
		render :template => 'api/v1/users/members/familyStatus' ,:handlers => [:rabl],:formats => [:json]
	end

  def getAllUsers
    if params[:userTerm].blank? 
      params[:userTerm] = nil
    end
    if params[:page].nil?
      params[:page] = 1
    end
    users =  User.getAllUsers(params[:user].id, params[:is_add_following].to_i,params[:userTerm],params[:page].to_i)
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new(users)
    })
    render :template => 'api/v1/users/members/getUsers' ,:handlers => [:rabl], :formats => [:json]
  end

  
	def getProfile
    if params[:user_id].nil? || User.isUserExistById(params[:user_id].to_i)
      params[:user_id] = params[:user].id
    end
    if params[:page].nil?
      params[:page] = 1
    end
    if params[:type].blank?
      params[:type] = 0 # 0 - feelikes , 1 - expirances, 2- todo list
    end
    userObj = UsersProfile.byUser(params[:user_id].to_i).first
    asset = {
      :id => -1,
      :uri=> ''
    }
    unless userObj.image_id.nil?  

      if userObj.image_id != 0 
        assetObj =  Assets.find_by_id(userObj.image_id).asset.url(:small)
        asset[:id] = userObj.image_id
        asset[:uri] = assetObj
      end
    end
    is_follow =  case UsersFollows.where({user_id:params[:user].id,ref_user_id: params[:user_id].to_i}).size
    when 0
      false
    else
      true
    end
    totalFollower = UsersFollows.followers(params[:user_id].to_i).uniq.size
    totalFolloing = UsersFollows.following(params[:user_id].to_i).uniq.size
    objectHash = {
      items: [],
      total: 0
    }
    if params[:type].to_i == 0 || params[:type].to_i == 2
	    objectHash = UsersContentItems.getUserItemsByType(params[:user_id].to_i,params[:page].to_i,params[:type].to_i)
    else
      objectHash = UsersExprience.getExpienceByUserProfile(params[:user_id].to_i,0,params[:page].to_i)
	  end

    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({
        items: objectHash[:items],
        total: objectHash[:total] ,
        is_follow:is_follow,
        totalFolloing: totalFolloing,
        totalFollower: totalFollower,
        fname: userObj.fname,
        lname: userObj.lname,
        image: asset
      })
    })
    render :template => 'api/v1/users/members/wall' ,:handlers => [:rabl],:formats => [:json]
	end

	#will get all follow users
	def getUsers
    if params[:userTerm].blank? 
      params[:userTerm] = nil
    end
    if params[:page].nil?
      params[:page] = 1
    end
    if params[:type].blank?
      params[:type] = 0 # 0 - ue  part. ,1 - exp followers, 2 user following, 3 user followers
    end
    if params[:id].blank? && !UsersExprience.isExists(params[:id].to_i) && params[:typeview] == 0
      params[:id] = 0 # 0 - ue  part. , user exp follow , 1 - reported, 2- global
    end
    users = nil
    case params[:type].to_i
    when 0
      user_existed = ''
      if params[:id].to_i != 0
        user_existed = UsersExprienceFollowers.following(params[:id].to_i).map(&:users_id).join(",") 
      else 
        user_existed = UsersExprienceFollowers.following(params[:id].to_i).map(&:user_id).join(",") 
      end
      unless UsersExprienceFollowers.following(params[:id].to_i).size != 0
        users = UsersFollows.followers(params[:user].id).uniq
      else
        users = UsersFollows.followers(params[:user].id).where("users_follows.user_id not in (" + user_existed +")").uniq
      end 
    when 1  
      users = UsersExprienceFollowers.following(params[:id].to_i).uniq
    when 2
      users = UsersFollows.following(params[:user].id).uniq
    else 
      users = UsersFollows.followers(params[:user].id).uniq
    end
    unless params[:userTerm].blank? 
      searchTerms = "%" + params[:userTerm].downcase + "%"
      users = users.where("lower(users_profiles.lname) like ? or lower(users_profiles.fname) like ?",searchTerms,searchTerms)
    end 
    users = users.page(params[:page].to_i).per(APP_CONFIG["Max_Page"])
    usersProfile = Array.new
    users.each do |item|
      userObj  = nil
      case params[:type].to_i
      when 2
        userObj = UsersProfile.byUser(item.ref_user_id).first
      when 3
        userObj = UsersProfile.byUser(item.user_id).first
      else
        userObj = UsersProfile.byUser(item.id).first
      end

      unless userObj.nil?
        asset = {
          :id => -1,
          :uri=> ''
        }
        unless userObj.image_id.nil?
          if userObj.image_id != 0 
            assetObj =  Assets.where({id:userObj.image_id}).first.asset.url(:small)
            asset[:id] = userObj.image_id
            asset[:uri] = assetObj
          end
        end
        is_ue = false
        is_follow = false
        if params[:type].to_i == 1&& !UsersExprience.isExists(params[:id].to_i)
          is_uep = !UsersExprienceParticipants.isExists(item.id,params[:id].to_i)
        end
        if params[:type].to_i == 2 
          is_follow = !UsersFollows.isExists(item.user_id,params[:user].id)
        end
        if params[:type].to_i == 3
          is_follow = UsersFollows.isExists(item.user_id,params[:user].id)
        end
      	dataHash ={
      		fname: userObj.fname,
      		lname: userObj.lname,
      		id: userObj.user_id,
      		image: asset,
          status: {
            is_follow: is_follow
          }
      	}
      	usersProfile.push(dataHash)
      end
    end
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({ items: usersProfile, total: users.num_pages }),
      timestamp: (Date.new).to_time.to_i.abs
    })
  	render :template => 'api/v1/users/members/getUsers' ,:handlers => [:rabl], :formats => [:json]
	end

	#will check if user has followers
	def hasFollowUsers
		hasFollowers ||= false
		hasFollowers = true unless User.followers.size == 0 
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: hasFollowers,
      timestamp: (Date.new).to_time.to_i.abs
    })
  	render :template => 'api/v1/users/members/status' ,:handlers => [:rabl], :formats => [:json]
	end

	#will check if user is following
	def hasFollowingUsers
		hasFollowing ||= false
		hasFollowing = true unless User.following.size == 0 

    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({ hasFollowing: hasFollowing }),
      timestamp: (Date.new).to_time.to_i.abs
    })
  	render :template => 'api/v1/users/members/status' ,:handlers => [:rabl], :formats => [:json]
	end

	#will get total follers
	def getTotalFollowers
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({ total: UsersFollows.followers(session[:user].id).uniq.size }),
      timestamp: (Date.new).to_time.to_i.abs
    })
  	render :template => 'api/v1/users/members/total' ,:handlers => [:rabl], :formats => [:json]
	end

	#will get total folloing
	def getTotalFollowing
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({ total: UsersFollows.following(session[:user].id).uniq.size }),
      timestamp: (Date.new).to_time.to_i.abs
    })
  	render :template => 'api/v1/users/members/total' ,:handlers => [:rabl], :formats => [:json]
	end

  def userPrefrences
    settingsObject = UsersSettings.where({user_id:params[:user].id}).first
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({ 
        feelike_status: settingsObject.feelike_status.to_i,
        follows_status: settingsObject.follows_status.to_i,
        experience_status: settingsObject.experience_status.to_i,
        experience_p_status: settingsObject.experience_p_status.to_i,        
        is_private: settingsObject.is_private_post
      }),
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/users/members/preference' ,:handlers => [:rabl], :formats => [:json]
  end

  def updateUserPrefrences
    settingsObject = UsersSettings.where({user_id:params[:user].id}).first
    settingsObject.update({
      experience_status:params[:experience_status].to_i,
      experience_p_status:params[:experience_p_status].to_i,
      follows_status:params[:follows_status].to_i,
      feelike_status:params[:feelike_status].to_i
    })
    self.default_response
  end

	#will get current user data
	def get
		#binding.pry
		templateFile = 'api/v1/users/members/get'
		unless (params[:id].to_i != 0 ) #will get the current user id if its nil or 0
			params[:id] = session[:user].id
			templateFile = 'api/v1/users/members/getFull'
		end
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new(User.getFullUserData(params[:id])),
      timestamp: (Date.new).to_time.to_i.abs
    })
  	render :template => templateFile ,:handlers => [:rabl], :formats => [:json]
	end
  
	#will update the user profile
	def updateProfile
    errors ||= Array.new
		dataHash = {
      user_id: params[:user].id,
      asset_id: params[:asset_id],
			fname: params[:fname],
			lname: params[:lname],
			gender: params[:gender],
			bio: params[:bio],
			familyStatus: params[:familyStatus],
			bdate: params[:bdate]
		}
		errors = Api::Init.MembersControl.checkProfileParams(dataHash)
		if errors.count != 0 
			render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['profile_errors'],I18n.t("errors.messages.users.profile_errors"), errors).to_json
    else
    	userProfileObject = UsersProfile.byUser(params[:user].id).first
      userProfileObject.updateProfile(dataHash)	
      self.default_response
    end
	end

	def addFollow
    errors ||= Array.new
    if params[:id].blank? && User.canAddFollwer(params[:id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0  
			UsersFollows.create({user_id:params[:user].id,ref_user_id:params[:id].to_i}) unless UsersFollows.where({user_id:params[:user].id,ref_user_id:params[:id].to_i}).size != 0
      Notifications.createNotification(params[:user].id,params[:id].to_i,  0,1)
      self.default_response
    else
    	render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['profile_errors'],I18n.t("errors.messages.users.profile_errors"), errors).to_json
    end
	end

	def removeFollow
    errors ||= Array.new
    if params[:id].blank? && User.canAddFollwer(params[:id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
    	folloerObj = UsersFollows.where({user_id:params[:user].id,ref_user_id:params[:id].to_i}).first
    	folloerObj.destroy().save()
      self.default_response
    else
    	render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['profile_errors'],I18n.t("errors.messages.users.profile_errors"), errors).to_json
    end
	end

	#will update the user Notifications
	def updateNotifications
		dataHash = {
			user_id: params[:user].id,
      experience_p_status: params[:experience_p_status],
      experience_status: params[:experience_status],
			feelike_status: params[:feelike_status],
			follows_status: params[:follows_status],
      comment_status: 0
		}
    UsersSettings.byUser(params[:user].id).first.updateNotifications(dataHash)
    self.default_response
	end

	#will register new user
	def register
		#binding.pry
		if session.has_key?("user") 
			dataHash = {
				email: params[:email],
				password: params[:password],
				password_confirmation: params[:password_confirmation],
				fname: params[:fname],
				lname: params[:lname],
				gender: params[:gender],
				familyStatus: params[:familyStatus],
				image_id: params[:image_id],
				bdate: params[:bdate],
        mobileToken: params[:mobileToken]
			}
			errors = Api::Init.MembersControl.checkRegisterParams(dataHash)
			if errors.count != 0 
				render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['register_error'],I18n.t("errors.messages.users.register_errors"), errors).to_json
	    else
				if User.isUserExist(params[:email]) 
					dataHash[:bdate] =   Date.strptime( dataHash[:bdate], '%m/%d/%Y')
					tmpUObject = User.register(dataHash)
					unless tmpUObject
						render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['register_user_exist'],I18n.t("errors.messages.users.register_errors"), [I18n.t("errors.messages.users.register_faild")]).to_json
        	else
            userObject = User.getFullUserData(tmpUObject.id)
		        @responseObject = OpenStruct.new({
		          status: true,
		          errors: [],
	      			code: API_CODE_ERRORS['Services']['Global']['success'],
		          objectData: OpenStruct.new(userObject),
              timestamp: (Date.new).to_time.to_i.abs
		        })
		      	render :template => 'api/v1/users/members/register' ,:handlers => [:rabl], :formats => [:json]
	        end
				else
					render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['register_user_exist'],I18n.t("errors.messages.users.register_errors"), [I18n.t("errors.messages.users.register_existedUser")]).to_json
				end
			end
		else
			render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['login_error'],I18n.t("errors.messages.users.register_errors"),[I18n.t("errors.messages.users.register_while_login")]).to_json
		end
	end

  def toggleAsPrivateMode
    UsersSettings.byUser(params[:user].id).first.toggelPrivateMode
    self.default_response
  end
  def getFbFriends
    users = params[:user].getFbFriendsList
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData:  OpenStruct.new({friends: users}),
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/users/members/fb_users' ,:handlers => [:rabl], :formats => [:json]
  end
	def connectSocal
    errors ||= Array.new
		if params[:type] != 'facebook' && params[:type] != 'twitter'
      errors.push(I18n.t("errors.messages.socal_invaild"))
    end
    if params[:id].blank?
      params[:id] = 0
    end
    if params[:token].blank?
      errors.push(I18n.t("errors.messages.feelike.input_string_empty"))
    end

    if errors.length == 0 
    	params[:user].connectSocal(params[:type],params[:id].to_i,params[:token])
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
	end

  def send_report
    errors ||= Array.new
    if params[:user_id].blank? &&User.isUserExistById(params[:user_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      userObject = User.getFullUserData(params[:user_id].to_i)
      Api::V1::Mailer::Reports.deliver_user(params[:user_id].to_i, userObject[:fname] + " , " + userObject[:lname]).deliver
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
	def unConnectSocal
    errors ||= Array.new
		if params[:type] != 'facebook' && params[:type] != 'twitter'
      errors.push(I18n.t("errors.messages.socal_invaild"))
    end

    if errors.length == 0 
    	params[:user].unConnectSocal(params[:type])
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
	end
end


