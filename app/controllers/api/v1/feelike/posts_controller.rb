class Api::V1::Feelike::PostsController < API::V1::BaseController
	prepend_before_filter :get_api_key
	before_filter :authenticate_user!
	skip_before_filter :verify_authenticity_token
  respond_to :json
  #will create new post
  def new
    errors ||= Array.new
    if params[:feeling_id].blank?&&Feelings.isExists(params[:feeling_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:item_id].blank?  &&ContentItem.isExists(params[:item_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:content].blank?
      params[:content] = ''
    end
    if params[:ue_id].blank?  &&UsersExprience.isExists(params[:ue_id].to_i)
      params[:ue_id] = nil
    end
    if errors.length == 0 
      Posts.create({user_id: params[:user].id ,asset_id:0, feeling_id:params[:feeling_id].to_i, content_item_id:params[:item_id].to_i,content:params[:content], userExprience_id:params[:ue_id].to_i})
      ContentItem.markAsFeelike(params[:user].id,params[:feeling_id].to_i,params[:ue_id],params[:item_id].to_i,0)
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def newImage
    errors ||= Array.new
    if params[:feeling_id].blank?&&Feelings.isExists(params[:feeling_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:asset_id].blank?  &&ContentItem.isExists(params[:asset_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:content].blank?
      params[:content] = ''
    end
    if params[:ue_id].blank?  &&UsersExprience.isExists(params[:ue_id].to_i)
      params[:ue_id] = nil
    end
    if errors.length == 0 
      Posts.create({user_id: params[:user].id  ,asset_id:params[:asset_id].to_i, feeling_id:params[:feeling_id].to_i, content_item_id:0,content:params[:content], userExprience_id:params[:ue_id].to_i})
      ContentItem.markAsFeelike(params[:user].id,params[:feeling_id].to_i,params[:ue_id],0,params[:asset_id].to_i)
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  #will update a post
  def update
    errors ||= Array.new
    if params[:fld_feeling_id].blank?&&Feelings.isExists(params[:fld_feeling_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:feeling_id].blank?&&Feelings.isExists(params[:feeling_id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if params[:item_id].blank? 
      params[:item_id]  = 0
    end
    if params[:asset_id].blank?  
      params[:asset_id] = 0
    end
    if params[:content].blank?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    if params[:fld_ue_id].blank?  &&UsersExprience.isExists(params[:fld_ue_id].to_i)
      params[:fld_ue_id] = nil
    end
    if params[:ue_id].blank?  &&UsersExprience.isExists(params[:ue_id].to_i)
      params[:ue_id] = nil
    end
    if errors.length == 0 
      postObj = nil
      unless params[:ue_id].to_i == 0 
        postObj = Posts.where({user_id:params[:user].id,asset_id:params[:asset_id].to_i, feeling_id:params[:feeling_id].to_i, content_item_id:params[:item_id].to_i,userExprience_id: params[:ue_id].to_i})
      else 
        postObj = Posts.where({user_id:params[:user].id,asset_id:params[:asset_id].to_i, feeling_id:params[:feeling_id].to_i, content_item_id:params[:item_id].to_i,userExprience_id: 0})
      end
      unless postObj.size == 0

        exp_id = nil
        exp_id = params[:ue_id].to_i unless params[:ue_id] != 0
        userItemObject = UsersContentItems.where({
          user_id:params[:user].id,
          asset_id:params[:asset_id].to_i, 
          feeling_id:params[:feeling_id].to_i, 
          content_item_id: params[:item_id].to_i,
          is_feelike: true,
          user_exprance_id: exp_id
        }).first
        postObj.first.updatePost(params[:user].id,params[:fld_feeling_id].to_i,params[:item_id].to_i,params[:asset_id].to_i,params[:fld_ue_id].to_i, params[:content],userItemObject)
      end
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  #will delete a post
  def destroy
    errors ||= Array.new
    if params[:id].blank? && Posts.isExists(params[:id].to_i)
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
      postObj = Posts.find_by_id(params[:id].to_i)
      postObj.is_delete  = true
      postObj.save
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
	#will get all post (feelike) under content item
	def getAll
    errors ||= Array.new
    if params[:item_id].blank? 
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
	  	postsItems = [    		
	  		{
	  			item_id: 3 , 
	  			feelike_id:2,  
	  			ue_id:2,
	  			user_id: 2,
	  			content: "Forever Alone" ,  
	  			status: 'recommand',
	  			create_at: '21/08/2011'
	  		},
	  		{
	  			item_id: 3 , 
	  			feelike_id:2,  
	  			ue_id:2,
	  			user_id: 2,
	  			content: "Forever Alone" ,  
	  			status: 'recommand',
	  			create_at: '21/08/2011'
	  		}
	  	]
	    self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
	end
	#will view single post
	def get
    errors ||= Array.new
    if params[:id].blank? ||params[:id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    if errors.length == 0 
	  	post={
  			item_id: 3 , 
  			feelike_id:2,  
  			ue_id:2,
  			user_id: 2,
  			content: "Forever Alone" ,  
  			status: 'recommand',
  			create_at: '21/08/2011'
  		}
	    self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
	end
	#will bind the post into the expirence
  def bindPostToExpirance
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
      self.default_response
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
end
