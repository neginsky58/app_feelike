class Api::V1::General::AssetsController < API::V1::BaseController

  prepend_before_filter :get_evn_api_key , except: [:destroy]
  prepend_before_filter :get_api_key, :only=> [ :destroy ]
  before_filter :authenticate_user!, :only=> [ :destroy ]
  before_filter :check_if_image_exist , :except=> [ :new ]
  skip_before_filter :verify_authenticity_token, :only=> [ :destroy ]
  respond_to :json
  def get
    image = @assetObject.asset.url(:small)
    imageExpBanner = @assetObject.asset.url(:expBanner)
    imageExpSmallImage = @assetObject.asset.url(:expSmallImage)
    imageExpBigImage = @assetObject.asset.url(:expBigImage)
    data = OpenStruct.new({
      id: @assetObject.id,
      uri: image,
      expBannerUri: imageExpBanner,
      expBigImageUri: imageExpBigImage,
      expSmallImageUri: imageExpSmallImage
    })
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: data,
      timestamp: (Date.new).to_time.to_i.abs
    })
    render :template => 'api/v1/general/assets/get' ,:handlers => [:rabl],:formats => [:json]
  end
  def new
    errors ||= Array.new
    if params[:file].blank? 
      errors.push(I18n.t("errors.messages.file_error"))
    end
    if errors.length == 0 
      begin
        assetObject = Assets.new(asset:params[:file])
        assetObject.save!
        image = assetObject.asset.url(:small)
        imageExpBanner = assetObject.asset.url(:expBanner)
        imageExpSmallImage = assetObject.asset.url(:expSmallImage)
        imageExpBigImage = assetObject.asset.url(:expBigImage)
        data = OpenStruct.new({
          id: assetObject.id,
          uri: image,
          expBannerUri: imageExpBanner,
          expBigImageUri: imageExpBigImage,
          expSmallImageUri: imageExpSmallImage
        })
  	    @responseObject = OpenStruct.new({
  	      status: true,
  	      errors: [],
  	      code: API_CODE_ERRORS['Services']['Global']['success'],
  	      objectData: data,
          timestamp: (Date.new).to_time.to_i.abs
  	    })
        render :template => 'api/v1/general/assets/new' ,:handlers => [:rabl],:formats => [:json]
      #rescue => e
      #  binding.pry
      #  logger.error e
       # errors.push(I18n.t("errors.messages.file_size_error"))
      #  render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['file_size'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
      end
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def destroy
      @assetObject.destroy.save
      self.default_response
  end
  private
  def check_if_image_exist
    errors ||= Array.new
    @assetObject ||= nil
    if params[:id].blank? ||params[:id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    @assetObject = Assets.find_by_id(params[:id])#.url(:small)
    if @assetObject.nil?
      errors.push(I18n.t("errors.messages.general.assets.image_not_found"))
    end
    if errors.length == 0 
      true
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
end
