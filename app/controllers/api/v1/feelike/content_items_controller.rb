class Api::V1::Feelike::ContentItemsController < API::V1::BaseController
	prepend_before_filter :get_api_key
	before_filter :authenticate_user!
	skip_before_filter :verify_authenticity_token
  respond_to :json
  def toggleAsTodo
    errors ||= Array.new
    if params[:item_id].blank? || params[:item_id].is_int || ContentItem.isExists(params[:item_id])
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:feeling_id].blank? ||params[:feeling_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      contentItemObj = ContentItem.find_by_id(params[:item_id]).triggerTodo(params[:user].id,params[:feeling_id].to_i)
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
   #this show the folloing wall basicly its has two mods 
  # 1. new user ( will get most newest items or p)
  # 2. existed user
  def getPopularRecommendedItems
    errors ||= Array.new
    if params[:page].blank? ||params[:page].is_int
      params[:page] = 0
    end

    if params[:page] == 0
      params[:page] = 1
    end
    objectHash = UsersContentItems.getRecommandedItems_bytype_all(params[:user].id , params[:page].to_i,1)
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({
        type: params[:is_new],
        items: objectHash[:items],
        total: objectHash[:total]
      }),
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/content_items/wall' ,:handlers => [:rabl],:formats => [:json]
  end
  #this show the folloing wall basicly its has two mods 
  # 1. new user ( will get most newest items or p)
  # 2. existed user
  def getRecommendedItems
    errors ||= Array.new
    
    if params[:page].blank? ||params[:page].is_int
      params[:page] = 0
    end

    if params[:page] == 0
      params[:page] = 1
    end
    objectHash = UsersContentItems.getRecommandedItems_bytype_all(params[:user].id , params[:page].to_i,0)
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({
        type: params[:is_new],
        items: objectHash[:items],
        total: objectHash[:total]
      }),
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/content_items/wall' ,:handlers => [:rabl],:formats => [:json]
  end
	#will get Recommend items type songs
	def getRecommendedByMusic
    errors ||= Array.new
    #if news items or popular ones (0=newst  , 1 = popular)
    if params[:is_new].blank? ||params[:is_new].is_int
      params[:is_new] = 0
    end
    
    if params[:page].blank? ||params[:page].is_int
      params[:page] = 0
    end

    if params[:page] == 0
      params[:page] = 1
    end
    objectHash = UsersContentItems.getRecommandedItems_bytype_music(params[:user].id , params[:page].to_i,params[:is_new].to_i)
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({
        type: params[:is_new],
        items: objectHash[:items],
        total: objectHash[:total]
      }),
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/content_items/wall' ,:handlers => [:rabl],:formats => [:json]
	end	
	#will get Recommend items type movie
	def getRecommendedByMovie
    errors ||= Array.new
    #if news items or popular ones (0=newst  , 1 = popular)
    if params[:is_new].blank? ||params[:is_new].is_int
      params[:is_new] = 0
    end
    
    if params[:page].blank? ||params[:page].is_int
      params[:page] = 0
    end

    if params[:page] == 0
      params[:page] = 1
    end
    objectHash = UsersContentItems.getRecommandedItems_bytype_movies(params[:user].id , params[:page].to_i)
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({
        type: params[:is_new],
        items: objectHash[:items],
        total: objectHash[:total]
      }),
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/content_items/wall' ,:handlers => [:rabl],:formats => [:json]
  end
	#will get Recommend items type book
	def getRecommendedByBook
    errors ||= Array.new
    #if news items or popular ones (0=newst  , 1 = popular)
    if params[:is_new].blank? ||params[:is_new].is_int
      params[:is_new] = 0
    end
    
    if params[:page].blank? ||params[:page].is_int
      params[:page] = 0
    end

    if params[:page] == 0
      params[:page] = 1
    end
    objectHash = UsersContentItems.getRecommandedItems_bytype_books(params[:user].id , params[:page].to_i)
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({
        type: params[:is_new],
        items: objectHash[:items],
        total: objectHash[:total]
      }),
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/content_items/wall' ,:handlers => [:rabl],:formats => [:json]
	end
	#will get Recommend items type restaurant
	def getRecommendedByRestaurant
    errors ||= Array.new
    if params[:feeling_id].blank? ||params[:feeling_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:category_id].blank? ||params[:category_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end

		#if news items or popular ones (0=newst  , 1 = popular)
    if params[:is_new].blank? ||params[:is_new].is_int
      params[:is_new] = 0
    end
		#if news items or popular ones (0=newst  , 1 = popular)
    if params[:range].blank? ||params[:range].is_int
      params[:range] = 5 #will search around 5km
    end
    if params[:lat].blank? ||params[:lat].is_int
      errors.push(I18n.t("errors.messages.gps_not_connected"))
    end
    if params[:log].blank? ||params[:log].is_int
      errors.push(I18n.t("errors.messages.gps_not_connected"))
    end

    if errors.length == 0 
    	contentItems = [    		
	  		{
	  			item_id: 3 , 
	  			name: "Forever Alone" ,  
	  			description:"Forever Alone",  
	  			asset:"http://media.mongodb.org/logo-mongoDB.png",
	  			type: 'recommand', 
	  			icon: 'restaurant',
	  			totalComments:22 , 
	  			totalTodo: 45 ,
	  			totalFeelike: 240 
	  		},
	  		{
	  			item_id: 4 , 
	  			name: "Forever Alone" ,  
	  			description:"Forever Alone",  
	  			asset:"http://media.mongodb.org/logo-mongoDB.png",
	  			type: 'recommand', 
	  			icon: 'restaurant',
	  			totalComments:22 , 
	  			totalTodo: 45 ,
	  			totalFeelike: 240 
	  		}
	  	]
	    @responseObject = OpenStruct.new({
	      status: true,
	      errors: [],
        code: API_CODE_ERRORS['Services']['Global']['success'],
	      objectData: {
	      	type: params[:is_new], 
	      	items: contentItems
	      },
        timestamp: (Date.new).to_time.to_i.abs
	    })
    	render :template => 'api/v1/feelike/content_items/list' ,:handlers => [:rabl],:formats => [:json]
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
	end
	#will take the items from the search / recommand to a play list
	def getPlaylist
	end
	#will get the comments of the content item
	def getComments
	end
	#will get the content item data
  def getContentItem
    errors ||= Array.new
    if params[:item_id].blank? || ContentItem.isExists(params[:item_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end

    if params[:feeling_id].blank? ||params[:feeling_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end

    if params[:ue_id].blank? ||params[:ue_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      contentItemObj = ContentItem.find_by_id(params[:item_id].to_i).getContentItem(params[:user].id,params[:feeling_id].to_i , params[:ue_id].to_i)
      @responseObject = OpenStruct.new({
        status: true,
        errors: [],
        code: API_CODE_ERRORS['Services']['Global']['success'],
        objectData: contentItemObj,
        timestamp: (Date.new).to_time.to_i.abs
      })
      render :template => 'api/v1/feelike/content_items/get' ,:handlers => [:rabl],:formats => [:json]
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  #will get the content item data type image
  def getContentItemByImage
    errors ||= Array.new
    if params[:asset_id].blank? 
      errors.push(I18n.t("errors.messages.element_not_id"))
    end

    if params[:feeling_id].blank? ||params[:feeling_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end

    if params[:ue_id].blank? ||params[:ue_id].is_int
      params[:ue_id] = 0
    end
    if errors.length == 0
      contentItemObj = nil
      if params[:ue_id].to_i == 0
        contentItemObj = UsersContentItems.where({content_item_id: 0 , feeling_id: params[:feeling_id].to_i , asset_id: params[:asset_id].to_i , user_exprance_id:nil}).first
      else
        contentItemObj = UsersContentItems.where({content_item_id: 0 , feeling_id: params[:feeling_id].to_i , asset_id: params[:asset_id].to_i , user_exprance_id:params[:ue_id].to_i}).first
      end 
      @responseObject = OpenStruct.new({
        status: true,
        errors: [],
        code: API_CODE_ERRORS['Services']['Global']['success'],
        objectData: contentItemObj.getContentItemByImage(params[:user].id,params[:feeling_id].to_i , params[:ue_id].to_i),
        timestamp: (Date.new).to_time.to_i.abs
      })
      render :template => 'api/v1/feelike/content_items/getImage' ,:handlers => [:rabl],:formats => [:json]
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
	#will search content items  by type song
	def searchByMusic
    errors ||= Array.new
    if params[:term].empty?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    if errors.length == 0 
      page ||= 1
      if params[:page].to_i != 1 && params[:page].to_i != 0
        page = params[:page].to_i
      end
      term = "%#{params[:term]}%"
      if ContentItem.where("(lower(name) like ? or lower(description) like ?) and category_id = ? and profile_youtube_id is not null" ,term,term,1).where({:created_at => 1.weeks.ago..DateTime.now}).size  == 0
        Api::ModulesLoaders.scanYoutube('Music',params[:term],10,method(:getContentItemsRender))
        self.getContentItemsRender(0,1,term,page)
      else
        self.getContentItemsRender(0,1,term,page)
      end
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
	end
	#will search content items  by type movie
	def searchByMovie
		#if news items or po
    errors ||= Array.new
    if params[:term].empty?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    if params[:feeling_id].blank?
      params[:feeling_id] = nil
    end
    if errors.length == 0 
      page ||= 1
      if params[:page].to_i != 1 && params[:page].to_i != 0
        page = params[:page].to_i
      end
      term = "%#{params[:term]}%"
      if ContentItem.where("(lower(name) like ? or lower(description) like ?) and category_id = ? and profile_itunes_id is not null" ,term,term,3).where({:created_at => 1.weeks.ago..DateTime.now}).size  == 0
        Api::ModulesLoaders.scanItunes('Movie',params[:term],10,method(:getContentItemsRender))
        self.getContentItemsRender(1,2,term,page)
      else
        self.getContentItemsRender(1,2,term,page)
      end
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
	end
	#will search content items  by type book
	def searchByBook
    #if news items or po
    errors ||= Array.new
    if params[:term].empty?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    if params[:feeling_id].blank?
      params[:feeling_id] = nil
    end
    if errors.length == 0 
      page ||= 1
      if params[:page].to_i != 1 && params[:page].to_i != 0
        page = params[:page].to_i
      end
      term = "%#{params[:term]}%"
      if ContentItem.where("(lower(name) like ? or lower(description) like ?) and category_id = ? and profile_amazon_id is not null" ,term,term,1).where({:created_at => 1.weeks.ago..DateTime.now}).size  == 0
        Api::ModulesLoaders.scanAmazon('Books',params[:term],10,method(:getContentItemsRender))
        self.getContentItemsRender(2,1,term,page)
      else
        self.getContentItemsRender(2,1,term,page)
      end
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
	end
  
	#will search content items  by type restaurant
	def searchByRestaurant
		#if news items or popular ones (0=newst  , 1 = popular)
    if params[:is_new].blank? ||params[:is_new].is_int
      params[:is_new] = 0
    end
  	contentItems = [    		
  		{
  			item_id: 3 , 
  			name: "Forever Alone" ,  
  			description:"Forever Alone",  
  			asset:"http://media.mongodb.org/logo-mongoDB.png",
  			type: 'recommand', 
  			icon: 'movie',
  			totalComments:22 , 
  			totalTodo: 45 ,
  			totalFeelike: 240 
  		},
  		{
  			item_id: 4 , 
  			name: "Forever Alone" ,  
  			description:"Forever Alone",  
  			asset:"http://media.mongodb.org/logo-mongoDB.png",
  			type: 'recommand', 
  			icon: 'movie',
  			totalComments:22 , 
  			totalTodo: 45 ,
  			totalFeelike: 240 
  		}
  	]
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: {
      	type: params[:is_new], 
      	items: contentItems
      }
    })
    render :template => 'api/v1/feelike/content_items/list' ,:handlers => [:rabl],:formats => [:json]
	end

	#will bind the content item into expirence
	def bindContentItemToExpirence
    errors ||= Array.new
    if params[:id].blank? ||params[:id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:ue_id].blank? ||params[:ue_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:feeling_id].blank? ||params[:feeling_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      render :template => 'api/v1/base/empty' ,:handlers => [:rabl],:formats => [:json]
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
	end

  def getFollowWall
    if params[:page].blank? ||params[:page].is_int
      params[:page] = 1
    end
    objectHash = UsersContentItems.getFollowerItems(params[:user].id,params[:page].to_i)

    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({
        type: 1,
        items: objectHash[:items],
        total: objectHash[:total]
      }),
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/content_items/wall' ,:handlers => [:rabl],:formats => [:json]
  end

  def getFeelikeMemebers
    errors ||= Array.new
    if params[:page].blank? ||params[:page].is_int
      params[:page] = 1
    end
    if params[:item_id].blank? ||params[:item_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:feeling_id].blank? ||params[:feeling_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 

      objectHash = UsersContentItems.getFeelikeMemebers(params[:user].id,params[:item_id].to_i,params[:feeling_id].to_i,params[:term],params[:page].to_i)
      @responseObject = OpenStruct.new({
        status: true,
        errors: [],
        code: API_CODE_ERRORS['Services']['Global']['success'],
        objectData: OpenStruct.new({
          type: 1,
          items: objectHash[:items],
          total: objectHash[:total]
        }),
        timestamp: (Date.new).to_time.to_i.abs
      })
      render :template => 'api/v1/feelike/content_items/wall' ,:handlers => [:rabl],:formats => [:json]
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def getTodoMemebers
    errors ||= Array.new
    if params[:page].blank? ||params[:page].is_int
      params[:page] = 1
    end
    if params[:item_id].blank? ||params[:item_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:feeling_id].blank? ||params[:feeling_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      objectHash = UsersContentItems.getTodoMemebers(params[:user].id,params[:item_id].to_i,params[:feeling_id].to_i,params[:term],params[:page].to_i)
      @responseObject = OpenStruct.new({
        status: true,
        errors: [],
        code: API_CODE_ERRORS['Services']['Global']['success'],
        objectData: OpenStruct.new({
          type: 1,
          items: objectHash[:items],
          total: objectHash[:total]
        }),
        timestamp: (Date.new).to_time.to_i.abs
      })
      render :template => 'api/v1/feelike/content_items/wall' ,:handlers => [:rabl],:formats => [:json]
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def addComment
    errors ||= Array.new
    if params[:item_id].blank? ||params[:item_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:feeling_id].blank? ||params[:feeling_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end

    if params[:ue_id].blank? ||params[:ue_id].is_int
      params[:ue_id] = 0
    end
    if errors.length == 0
      
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  
  protected
  #get the conent items by type: 0 = youtube , 1 = amazon , 2 = itunes
  def getContentItemsRender(type,providorCategory_id, term , page=1)
    objectHash = {
      items: Array.new,
      total: 0
    }
    objectHash = ContentItem.getContentItems(type,providorCategory_id, term , page,params[:user].id)
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({
        type: 1,
        items: objectHash[:items],
        total: objectHash[:total]
      }),
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/content_items/wall' ,:handlers => [:rabl],:formats => [:json] 
  end
end