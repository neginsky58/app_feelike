class ContentItem < ActiveRecord::Base
	has_one :content_item_age_ranges, :dependent => :destroy
	has_one :users_content_items, :dependent => :destroy
  belongs_to :categories
  belongs_to :family_genders
  belongs_to :content_items_amazons
  belongs_to :content_items_faculties
  belongs_to :content_items_itunes
  belongs_to :content_items_youtubes
  attr_accessible :create_at, :id,:name, :description, :category_id, :modfiy_at, :shares, :user_gender, :views ,:profile_faculty_id,:profile_itunes_id,:profile_amazon_id,:profile_youtube_id, :is_active , :is_delete
  default_scope where("content_items.is_active = true and content_items.is_delete = false")

  scope :consumeGlobalItemByTerm , (lambda do |searchTerm| 
  	searchTerm ||= ''
		searchStr = sprintf("(content_items.name like '%s' or content_items.description like '%s') and content_items.id <> (select content_item_id from users_content_items where content_items.id = users_content_items.content_item_id and users_content_items.is_feelike = 't' and users_content_items.is_todo = 't' )"  ,'%'+searchTerm+'%','%'+searchTerm+'%') 
		joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
		.joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
		.joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
		.joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
		.where(searchStr) if searchTerm.nil? || searchTerm != ""
  end)
  scope :consumeGlobalItemById , (lambda do |item_id| 
		joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
		.joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
		.joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
		.joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
		.where("content_items.id = ?" , item_id) unless item_id.nil?
  end)
  def triggerTodo(user_id,feeling_id)
    userContentItem = UsersContentItems.where({:content_item_id => self.id,:asset_id =>0,:feeling_id => feeling_id ,:user_id => user_id,:is_todo =>true}).first_or_create({
      content_item_id: self.id,
      is_feelike: false,
      is_todo: false,
      feeling_id: feeling_id,
      is_active:true,
      is_delete:false
    })
    userContentItem.is_todo  = !userContentItem.is_todo
    userContentItem.save
  end
  def self.markAsFeelike(user_id,feeling_id,ue_id,item_id,asset_id=0)
    userContentItem = UsersContentItems.where({:content_item_id => item_id,:asset_id => asset_id,:feeling_id => feeling_id ,:user_id => user_id,:is_feelike => true}).first_or_create({
      content_item_id: item_id,
      asset_id: asset_id,
      feeling_id: feeling_id,
      user_exprance_id: ue_id,
      user_id: user_id,
      is_feelike: true,
      is_todo: false,
      is_active:true,
      is_delete:false
    })
    userContentItem.is_feelike  = true
    userContentItem.save
  end


  def self.isExists(item_id) 
    isExisted = false
    if ContentItem.find_by_id(item_id).nil?
      isExisted = true
    end
    isExisted
  end

  def getContentItem(user_id,feeling_id,ue_id)
    totalTodo ||= 0
    totalFeelike ||= 0
    totalComments ||= 0
    feeling ||= ''
    isMarkTodo = false
    if UsersContentItems.hadUsersExistedContentItem(self.id,0,user_id)
      ue_id = nil unless ue_id != 0
      #userContentItemData = UsersContentItems.where({content_item_id:self.id , asset_id:0,feeling_id:feeling_id,user_exprance_id:ue_id,user_id:user_id}).first()
      totalTodo = UsersContentItems.consumeGlobalItemById(self.id).where({:is_todo =>true}).size
      totalFeelike = UsersContentItems.consumeGlobalItemById(self.id).where({:is_feelike => true}).size
      totalComments = PostsComments.commentByItem(self.id).size
      markTodoObj = UsersContentItems.consumeGlobalItemById(self.id).where({feeling_id:feeling_id,user_exprance_id:ue_id, :is_todo =>true , :user_id =>user_id})
      isMarkTodo = markTodoObj.first().is_todo unless markTodoObj.size ==0
    end
    image_uri = ''
    aff_link_str = ""
    profile_object = self.getContentItemProfile(self)
    unless self.profile_youtube_id.nil?
      image_uri = profile_object.image_uri
    end
    unless self.profile_itunes_id.nil?
      image_uri = profile_object.artwork_uri
      #aff_link = 
      aff_link_str = "http://click.linksynergy.com/fs-bin/click?id=mBx*h4jBETM&offerid=146261.10006070&type=4&subid=0&RD_PARM1=%s" % [CGI.encode(ItunesAffiliate.affiliate_link(profile_object.track_view_uri,:linkshare))]
    end
    objectData = {
      item_id: self.id,
      name: self.name,
      description: self.description,
      created_at: self.created_at,
      category_id: self.category_id,
      category_name: Categories.active.find_by_id(self.category_id).name,
      category_icon: '',
      totalComments: totalComments,
      totalFeelike: totalFeelike,
      totalTodo: totalTodo,
      feeling_id: feeling_id,
      is_mark_todo: isMarkTodo,
      asset: image_uri,
      aff_link: aff_link_str,
      item_data: profile_object
    }
    objectData
  end

  def self.getAssetItem(user_id,feeling_id,ue_id ,asset_id)
    totalTodo ||= 0
    totalFeelike ||= 0
    totalComments ||= 0
    feeling ||= ''
    isMarkTodo = false
    if UsersContentItems.hadUsersExistedContentItem(0,asset_id,user_id)
      ue_id = nil unless ue_id != 0
      #userContentItemData = UsersContentItems.where({content_item_id:0 , asset_id:asset_id,feeling_id:feeling_id,user_exprance_id:ue_id,user_id:user_id}).first()
      totalTodo = UsersContentItems.consumeGlobalItemById(self.id).where({:is_todo =>true}).size
      totalFeelike = UsersContentItems.consumeGlobalItemById(self.id).where({:is_feelike => true}).size
      totalComments = PostsComments.commentByItem(self.id).size
      markTodoObj = UsersContentItems.consumeGlobalItemById(self.id).where({feeling_id:feeling_id,user_exprance_id:ue_id, :is_todo =>true , :user_id =>user_id})
      isMarkTodo = markTodoObj.first().is_todo unless markTodoObj.size ==0
    end
    image_uri = ''
    profile_object = self.getContentItemProfile(self)
    unless self.profile_youtube_id.nil?
      image_uri = profile_object.image_uri
    end
    unless self.profile_itunes_id.nil?
      image_uri = profile_object.artwork_uri
    end
    objectData = {
      item_id: self.id,
      name: self.name,
      description: self.description,
      created_at: self.created_at,
      category_id: self.category_id,
      category_name: Categories.active.find_by_id(self.category_id).name,
      category_icon: '',
      totalComments: totalComments,
      totalFeelike: totalFeelike,
      totalTodo: totalTodo,
      feeling_id: feeling_id,
      is_mark_todo: isMarkTodo,
      asset: image_uri,
      item_data: profile_object
    }
    objectData
  end

  def self.getContentItems(type,providorCategory_id, term , page,user_id)
    items = Array.new
    case type
    when 0
      itemsData = self.where("(lower(name) like ? or lower(description) like ?) and category_id = ? and profile_youtube_id is not null" ,term.downcase,term.downcase,providorCategory_id).where(:created_at => 1.weeks.ago..DateTime.now).order("id desc").page(page).per(APP_CONFIG["Max_Page"])
    when 1
      itemsData = self.where("(lower(name) like ? or lower(description) like ?) and category_id = ? and profile_itunes_id is not null" ,term.downcase,term.downcase,providorCategory_id).where(:created_at => 1.weeks.ago..DateTime.now).order("id desc").page(page).per(APP_CONFIG["Max_Page"])
    when 2
      itemsData = self.where("(lower(name) like ? or lower(description) like ?) and category_id = ? and profile_amazon_id is not null" ,term.downcase,term.downcase,providorCategory_id).where(:created_at => 1.weeks.ago..DateTime.now).order("id desc").page(page).per(APP_CONFIG["Max_Page"])
    when 3
      itemsData = self.where("(lower(name) like ? or lower(description) like ?) and category_id = ? and profile_youtube_id is not null" ,term.downcase,term.downcase,providorCategory_id).where(:created_at => 1.weeks.ago..DateTime.now).order("id desc").page(page).per(APP_CONFIG["Max_Page"])
    end
    itemsData.each do |item|
      profile_object = self.getContentItemProfile(item)
      totalTodo ||= 0
      totalFeelike ||= 0
      totalComments ||= 0
      feeling ||= ''
      if UsersContentItems.hadUsersExistedContentItem(item.id,0,user_id)
       # userContentItemData = UsersContentItems.where({content_item_id:item.id}).first
        totalTodo = UsersContentItems.consumeGlobalItemById(item.id).where({:is_todo =>true , :is_feelike => false}).size
        totalFeelike = UsersContentItems.consumeGlobalItemById(item.id).where({:is_todo =>false , :is_feelike => true}).size
        totalComments = PostsComments.commentByItem(item.id).size
      end
      image_uri = ''
      case type
      when 0
        image_uri = profile_object.image_uri
      when 1
        image_uri = profile_object.artwork_uri
      when 2
      when 3
      end
      objectData = {
        item_id: item.id,
        name: item.name,
        description: item.description,
        category_id: item.category_id,
        created_at: item.created_at.strftime("%m/%d/%Y %H:%M:%S"),
        category_name: Categories.active.find_by_id(item.category_id).name,
        category_icon: '',
        totalComments: totalComments,
        totalTodo: totalTodo,
        totalFeelike: totalFeelike,
        feeling_id: 0,
        asset: image_uri,
        item_data: profile_object
      }
      items.push(objectData)
    end
    objectHash = {
      items: items,
      total: itemsData.num_pages
    }
    objectHash
  end
  def self.getRecommendedItems(term,page)
    items = Array.new
  	itemsData = ContentItem.consumeGlobalItemByTerm(term).where(:created_at => 1.weeks.ago..DateTime.now).page(page).per(APP_CONFIG["Max_Page"])
    itemsData.each do |item|
  		totalTodo = 0
  		totalFeelike = 0
  		totalComments = 0
  		#feeling = ''

      profile_object = self.getContentItemProfile(item)
  		#asset =  Assets.find_by_id(conentItem.categories.image).small
  		objectData = {
  			item_id: item.id,
  			name: item.name,
  			description: item.description,
        created_at: item.created_at.strftime("%m/%d/%Y %H:%M:%S"),
  			category_id: item.category_id,
  			category_name: Categories.active.find_by_id(item.category_id).name,
  			category_icon: '',
  			totalComments: totalComments,
        totalFeelike: totalFeelike,
  			totalTodo: totalTodo,
  			feeling_id: 0,
        item_data: profile_object
  		}
      items.push(objectData)
  	end
    objectHash = {
      items: items,
      total: itemsData.num_pages
    }
  	objectHash
  end
  protected
  def getContentItemProfile(item)
    profile_object = nil
    unless item.profile_youtube_id.nil?
      profile_object = ContentItemsYoutube.profileByItem(item.profile_youtube_id).first()
    end
    unless item.profile_faculty_id.nil?
      profile_object = ContentItemsFaculty.profileByItem(item.profile_faculty_id).first()
    end
    unless item.profile_itunes_id.nil?
      profile_object = ContentItemsItunes.profileByItem(item.profile_itunes_id).first()
    end
    unless item.profile_amazon_id.nil?
      profile_object = ContentItemsAmazon.profileByItem(item.profile_amazon_id).first()
    end
    profile_object
  end
  def self.getContentItemProfile(item)
    profile_object = nil
    unless item.profile_youtube_id.nil?
      profile_object = ContentItemsYoutube.profileByItem(item.profile_youtube_id).first()
    end
    unless item.profile_faculty_id.nil?
      profile_object = ContentItemsFaculty.profileByItem(item.profile_faculty_id).first()
    end
    unless item.profile_itunes_id.nil?
      profile_object = ContentItemsItunes.profileByItem(item.profile_itunes_id).first()
    end
    unless item.profile_amazon_id.nil?
      profile_object = ContentItemsAmazon.profileByItem(item.profile_amazon_id).first()
    end
    profile_object
  end
end