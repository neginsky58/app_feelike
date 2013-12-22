class Api::V1::General::PagesController < API::V1::BaseController
  include ActionView::Helpers::SanitizeHelper
  prepend_before_filter :get_api_key
  before_filter :authenticate_user!,except: [:get]
  before_filter :check_exist_page , except: [:new]
  before_filter :check_new_page , only: [:new]
  skip_before_filter :verify_authenticity_token
  respond_to :json
  def get
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: @page
    })
    render :template => 'api/v1/general/pages/get' ,:handlers => [:rabl],:formats => [:json]
  end
  def new
    tags = %w(a acronym b strong i em li ul ol h1 h2 h3 h4 h5 h6 blockquote br cite sub sup ins p)
    params[:name] = strip_tags(params[:name])
    params[:title] = sanitize(params[:title], tags: tags, attributes: %w(href title))
    params[:content] = sanitize(params[:content], tags: tags, attributes: %w(href title))
    page = PageViews.new({name: params[:name],title: params[:title],content: params[:content], is_published: true})
    page.save!
    @responseObject = OpenStruct.new({
      status: true,
      errors: [],
      code: API_CODE_ERRORS['Services']['Global']['success'],
      objectData: page
    })
    render :template => 'api/v1/general/pages/get' ,:handlers => [:rabl],:formats => [:json]
  end
  def update
    if params[:content].blank? 
      params[:content] = ""
    end
    tags = %w(a acronym b strong i em li ul ol h1 h2 h3 h4 h5 h6 blockquote br cite sub sup ins p)
    params[:content] = sanitize(params[:content], tags: tags, attributes: %w(href title))
    @page.content = params[:content]
    @page.save
    self.default_response
  end
  def destroy
    @page.destroy.save
    self.default_response
  end
  private 
  def check_new_page 
    errors ||= Array.new
    if params[:name].blank?
      errors.push(I18n.t("errors.messages.input_string_empty"))
    end
    pageIns = PageViews.where("name = ?" , strip_tags(params[:name])).size
    if pageIns != 0
      errors.push(I18n.t("errors.messages.general.pages.page_existed"))
    end
    if params[:content].blank? 
      params[:content] = ""
    end
    if errors.length == 0 
      true
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
  def check_exist_page 
    errors ||= Array.new
    if params[:id].blank? ||params[:id].is_int
      errors.push(I18n.t("errors.messages.element_not_id"))
    end
    @page = PageViews.find_by_id(params[:id])
    if @page.nil?
      errors.push(I18n.t("errors.messages.general.pages.page_not_existed"))
    end
    if errors.length == 0 
      true
    else
      render :json => Api::Init.ShowErrorJson(API_CODE_ERRORS['Services']['Global']['formInputError'],I18n.t("errors.messages.feelike.input_error"), errors).to_json
    end
  end
end
