class Api::V1::Feelike::CategoriesController < API::V1::BaseController
  prepend_before_filter :get_api_key
  before_filter :authenticate_user!
  before_filter :check_exist_category ,except: [:new,:getAll]
  before_filter :check_new_category ,only: [:new]
  before_filter :verify_asset ,only: [:update,:new]
  skip_before_filter :verify_authenticity_token 
  respond_to :json
  def getAll
    categorys = Categorys.find(:all)
    responseData ||= Array.new
    categorys.each do |category|
      imageIns = Assets.find_by_id(category.image_id)
      responseData.push(OpenStruct.new({
        id: category.id,
        name: category.name ,
        asset_uri: imageIns.asset.url(:small)
      }))
    end

    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: OpenStruct.new({
        items:responseData ,
        total: categorys.size
      }),
      timestamp: (Date.new).to_time.to_i.abs
    })
    logger.info(@responseObject )
    render :template => 'api/v1/feelike/categories/list' ,:handlers => [:rabl],:formats => [:json]
  end

  def get
    responseData = OpenStruct.new({
      id: @category.id,
      name: @category.name ,
      asset_uri: @imageIns.asset.url(:small)
    })
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: responseData,
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/categories/get' ,:handlers => [:rabl],:formats => [:json]
  end
  def new
    obj = Categorys.new({name: params[:name],image_id:@imageIns.id})
    obj.save!
    responseData = OpenStruct.new({
      id: obj.id,
      name: obj.name ,
      asset_uri: @imageIns.asset.url(:small)
    })
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: responseData,
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/feelike/categories/get' ,:handlers => [:rabl],:formats => [:json]
  end
  def update
    if params[:name].blank?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    @category.name = params[:name]
    @category.image_id = @imageIns.id
    @category.save
    
    self.default_response
  end
  def destroy
    @category.destroy.save
    self.default_response
  end
  private 
  def verify_asset
    errors ||= Array.new
    if params[:asset_id].blank? ||params[:asset_id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    @imageIns = Assets.find_by_id(params[:asset_id])
    if @imageIns.nil?
      errors.push(I18n.t("errors.messages.feelike.asset_requeire"))
    end
    if errors.length == 0 
      true
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def check_new_category 
    errors ||= Array.new
    if params[:name].blank?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    objIns = Categorys.where("name = ?" , params[:name]).size
    if objIns != 0
      errors.push(I18n.t("errors.messages.feelike.categories.cateogry_existed"))
    end
    if errors.length == 0 
      true
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def check_exist_category 
    errors ||= Array.new
    if params[:id].blank? ||params[:id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    @category = Categorys.find_by_id(params[:id])
    if @category.nil?
      errors.push(I18n.t("errors.messages.feelike.categories.cateogry_not_existed"))
    end
    @imageIns = Assets.find_by_id(@category.image_id)
    if errors.length == 0 
      true
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
end
