class UsersContentItems < ActiveRecord::Base
  belongs_to :users
  belongs_to :content_items
  attr_accessible :content_item_id,:asset_id,:user_id,:feeling_id,:is_todo,:is_feelike, :id, :is_active , :is_delete,:created_at,:id,:user_exprance_id
  default_scope where("users_content_items.is_active = true and users_content_items.is_delete = false")

  scope :consumeGlobalItemByTerm , (lambda do |searchTerm| 
    searchTerm ||= ''
    searchStr = sprintf("content_items.name like '%s' or content_items.description like '%s'"  ,'%'+searchTerm+'%','%'+searchTerm+'%')
    joins("INNER JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where(searchStr) if searchTerm.nil? || searchTerm != ""
  end)

  scope :consumeGlobalItemMusicByUEID , (lambda do |ue_id| 
    joins("INNER JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where({:user_exprance_id => ue_id}) 
    .where("content_items.profile_youtube_id is not null")
  end)

  scope :consumeGlobalItemBooksByUEID , (lambda do |ue_id| 
    joins("INNER JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where({:user_exprance_id => ue_id}) 
    .where("content_items.profile_amazon_id is not null")
  end)

  scope :consumeGlobalItemRestByUEID , (lambda do |ue_id| 
    joins("INNER JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where({:user_exprance_id => ue_id}) 
    .where("content_items.profile_faculty_id is not null")
  end)

  scope :consumeGlobalItemHangoutByUEID , (lambda do |ue_id| 
    joins("INNER JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where({:user_exprance_id => ue_id}) 
    .where("content_items.profile_faculty_id is not null")
  end)

  scope :consumeGlobalItemMoviesByUEID , (lambda do |ue_id| 
    joins("INNER JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where({:user_exprance_id => ue_id}) 
    .where("content_items.profile_itunes_id is not null")
  end)

  scope :consumeGlobalItemAllByUEID , (lambda do |ue_id| 
    joins("INNER JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where({:user_exprance_id => ue_id}) 
  end)

  scope :consumeGlobalItemById , (lambda do |item_id| 
    joins("INNER JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where("content_items.id = ?" , item_id) unless item_id.nil?
  end)

  scope :consumeGlobalItemByUserId , (lambda do |user_id| 
    #binding.pry
    joins("left JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where("users_content_items.user_id = ? or users_content_items.user_id in(?)" , user_id,UsersFollows.followersWithPrivacyMode(user_id).map(&:ref_user_id)) unless user_id.nil?
  end)

  scope :consumeGlobalItemForTodoByUserId , (lambda do |user_id| 
    #binding.pry
    joins("left JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where("users_content_items.user_id = ?" , user_id) unless user_id.nil?
  end)

  scope :consumeMusicItemByUserId , (lambda do |user_id| 
    #binding.pry
    joins("left JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where("users_content_items.user_id = ? or users_content_items.user_id in(?)" , user_id,UsersFollows.followersWithPrivacyMode(user_id).map(&:ref_user_id)) unless user_id.nil?
    .where("content_items.profile_youtube_id is not null")
  end)
  scope :consumeBooksItemByUserId , (lambda do |user_id| 
    #binding.pry
    joins("left JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where("users_content_items.user_id = ? or users_content_items.user_id in(?)" , user_id,UsersFollows.followersWithPrivacyMode(user_id).map(&:ref_user_id)) unless user_id.nil?
    .where("content_items.profile_amazon_id is not null")
  end)
  scope :consumeMoviesItemByUserId , (lambda do |user_id| 
    #binding.pry
    joins("left JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where("users_content_items.user_id = ? or users_content_items.user_id in(?)" , user_id,UsersFollows.followersWithPrivacyMode(user_id).map(&:ref_user_id)) unless user_id.nil?
    .where("content_items.profile_itunes_id is not null")
  end)
  scope :consumeRestItemByUserId , (lambda do |user_id| 
    #binding.pry
    joins("left JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where("users_content_items.user_id = ? or users_content_items.user_id in(?)" , user_id,UsersFollows.followersWithPrivacyMode(user_id).map(&:ref_user_id)) unless user_id.nil?
    .where("content_items.profile_faculty_id is not null")
  end)
  scope :consumeHangoutItemByUserId , (lambda do |user_id| 
    #binding.pry
    joins("left JOIN content_items on users_content_items.content_item_id  = content_items.id")
    .joins("left JOIN content_items_amazons on content_items_amazons.id  = content_items.profile_amazon_id")
    .joins("left JOIN content_items_itunes on content_items_itunes.id  = content_items.profile_itunes_id")
    .joins("left JOIN content_items_faculties on content_items_faculties.id  = content_items.profile_faculty_id")
    .joins("left JOIN content_items_youtubes on content_items_youtubes.id  = content_items.profile_youtube_id")
    .where("users_content_items.user_id = ? or users_content_items.user_id in(?)" , user_id,UsersFollows.followersWithPrivacyMode(user_id).map(&:ref_user_id)) unless user_id.nil?
    .where("content_items.profile_faculty_id is not null")
  end)

  def self.hadUsersExistedContentItem(item_id ,asset_id,user_id,is_new = false) 
    isExisted = false
    unless UsersContentItems.where("(users_content_items.content_item_id = ?  and users_content_items.asset_id = ?) and users_content_items.user_id = ?" ,item_id ,asset_id, user_id).first.nil?
      isExisted = true
    end
    isExisted
  end

  def self.get(item,user_id)
    self.scanByType(item,user_id)
  end

  def self.getRecommandedItems_bytype_all (user_id,page,is_new)
    items = Array.new
    itemsData = nil
    if is_new ==0
      itemsData = self.consumeGlobalItemByUserId(user_id)
      itemsData = itemsData.order("users_content_items.created_at desc").page(page).per(APP_CONFIG["Max_Page"])
      itemsData.each{|item| items.push(scanByType(item,user_id)) } 
    else
      itemsData = self.where("users_content_items.content_item_id in (?)" , StatsContentItems.overall.order('overall_counter').map(&:item_id))
      itemsData = itemsData.order("users_content_items.created_at desc").page(page).per(APP_CONFIG["Max_Page"])
      itemsData.each{|item| items.push(scanByType(item,user_id)) } 
    end
    itemsData.reject!(&:nil?)
    objectHash = {
      items: items,
      total: itemsData.num_pages
    }
    objectHash
  end

  def self.getRecommandedItems_bytype_music (user_id,page)
    items = Array.new
    itemsData = self.consumeMusicItemByUserId(user_id).page(page).per(APP_CONFIG["Max_Page"])
    itemsData.each{|item| items.push(self.scanByType(item,user_id)) } 
    itemsData.reject!(&:nil?)
    objectHash = {
      items: items,
      total: itemsData.num_pages
    }
    objectHash
  end


  def self.getRecommandedItems_bytype_movies (user_id,page)
    items = Array.new
    itemsData = self.consumeMoviesItemByUserId(user_id).page(page).per(APP_CONFIG["Max_Page"])
    itemsData.each{|item| items.push(self.scanByType(item,user_id)) } 
    itemsData.reject!(&:nil?)
    objectHash = {
      items: items,
      total: itemsData.num_pages
    }
    objectHash
  end

  def self.getRecommandedItems_bytype_books (user_id,page)
    items = Array.new
    itemsData = self.consumeBooksItemByUserId(user_id).page(page).per(APP_CONFIG["Max_Page"])
    itemsData.each{|item| items.push(self.scanByType(item,user_id)) } 
    itemsData.reject!(&:nil?)
    objectHash = {
      items: items,
      total: itemsData.num_pages
    }
    objectHash
  end

  def self.getFollowerItems(user_id,page) 
    items = Array.new
    itemsData = self.consumeGlobalItemByUserId(user_id).where("feeling_id is not null").order("users_content_items.created_at desc").page(page).per(APP_CONFIG["Max_Page"])
    itemsData.each{|item| items.push(self.scanByType(item,user_id)) } 
    itemsData.reject!(&:nil?)
    objectHash = {
      items: items,
      total: itemsData.num_pages
    }
    objectHash
  end

  def getContentItemByImage(user_id,feeling_id,ue_id)
    totalTodo ||= 0
    totalFeelike ||= 0
    totalComments ||= 0
    feeling ||= ''
    isMarkTodo = false
    exp_name = ''
    exp_id = 0
    asset = {
      :id => -1,
      :uri=> ''
    }
    if UsersContentItems.hadUsersExistedContentItem(self.id,0,user_id)
      ue_id = nil unless ue_id != 0
      userContentItemData = self
      totalTodo = UsersContentItems.consumeGlobalItemById(self.id).where({:is_todo =>true}).size
      totalFeelike = UsersContentItems.consumeGlobalItemById(self.id).where({:is_feelike => true}).size
      totalComments = PostsComments.commentByItem(self.id).size
      markTodoObj = UsersContentItems.consumeGlobalItemById(self.id).where({feeling_id:feeling_id,user_exprance_id:ue_id, :is_todo =>true , :user_id =>user_id})
      isMarkTodo = markTodoObj.first().is_todo unless markTodoObj.size ==0
    end
    unless self.user_exprance_id.nil?
      exp_id = self.user_exprance_id
    end
    postObj =  Posts.where({:user_id => self.user_id, :feeling_id => self.feeling_id, :content_item_id=>0, :asset_id=>self.asset_id, :userExprience_id=>exp_id})
    binding.pry
    userObj = UsersProfile.byUser(self.user_id).first
    userSetttings = UsersSettings.byUser(self.user_id).first
    unless userObj.image_id.nil?
      if userObj.image_id != 0 
        assetObj =  Assets.find_by_id(userObj.image_id).asset.url(:small)
        asset[:id] = userObj.image_id
        asset[:uri] = assetObj
      end
    end
    image_uri = ''
    assetObject = {
      id: -1 ,
      uri: ""
    }
    assetObj =  Assets.find_by_id(self.asset_id).asset.url(:expBigImage)
    assetObject[:id] = self.asset_id
    assetObject[:uri] = assetObj
    description= postObj.first.content
    expRecored = UsersExprience.where({id:postObj.first.userExprience_id})
    exp_name = expRecored.first().name if postObj.first.userExprience_id != 0 && expRecored.size != 0
    exp_id = postObj.first.userExprience_id
    objectData = {
      item_id: self.id,
      name: "",
      creator: {
        fname: userObj.fname,
        lname: userObj.lname,
        image: {
          id: asset[:id],
          uri: asset[:uri]
        },
        user_id: self.user_id
      },
      description: description,
      exp_name: exp_name,
      exp_id:exp_id,
      created_at: self.created_at,
      category_id: 0,
      category_name: "Images",
      category_icon: '',
      totalComments: totalComments,
      totalFeelike: totalFeelike,
      totalTodo: totalTodo,
      feeling_id: feeling_id,
      is_mark_todo: isMarkTodo,
      asset: assetObject
    }
    objectData
  end
  def self.getUserItemsByType(user_id,page,type)
    items = Array.new
    itemsData = self.consumeGlobalItemByUserId(user_id)
    itemsData = itemsData.where ({user_id: user_id})
    case type
    when 0 #for feelike
      itemsData = itemsData.where({:is_feelike => true ,:is_todo =>false}).order("users_content_items.created_at desc").page(page).per(APP_CONFIG["Max_Page"])
    when 1 #for exp
      itemsData = itemsData.where({:is_feelike => true ,:is_todo =>false }).where("users_expriences_id is not null or users_expriences_id != 0").order("users_content_items.created_at desc").page(page).per(APP_CONFIG["Max_Page"])
    when 2 #for todo
      itemsData = self.consumeGlobalItemForTodoByUserId(user_id)
      itemsData = itemsData.where ({user_id: user_id})
      itemsData = itemsData.where({:is_todo =>true}).order("users_content_items.created_at desc").page(page).per(APP_CONFIG["Max_Page"])
    end
    itemsData.each{|item| items.push(self.scanByType(item,user_id)) } 
    itemsData.reject!(&:nil?)
    objectHash = {
      items: items,
      total: itemsData.num_pages
    }
    objectHash
  end
  def self.getFollowerItemsByType(user_id,page,type) 
    items = Array.new

    case type
    when 0 #for feelike
      itemsData = itemsData.where({:is_feelike => true ,:is_todo =>false}).order("users_content_items.created_at desc").page(page).per(APP_CONFIG["Max_Page"])
    when 1 #for exp
      itemsData = itemsData.where({:is_feelike => true ,:is_todo =>false }).where("user_exprance_id is not null or user_exprance_id != 0").order("users_content_items.created_at desc").page(page).per(APP_CONFIG["Max_Page"])
    when 2 #for todo
      itemsData = itemsData.where({:is_todo =>true}).order("users_content_items.created_at desc").page(page).per(APP_CONFIG["Max_Page"])
    end
    itemsData.each{|item| items.push(self.scanByType(item,user_id)) } 
    objectHash = {
      items: items,
      total: itemsData.num_pages
    } 
    objectHash
  end
  def self.getTodoMemebers(user_id , item_id , feeling_id,term,page )
    items = Array.new
    itemsData = self.consumeGlobalItemById(item_id).where("users_content_items.feeling_id  is null or users_content_items.feeling_id = ?",feeling_id)
    
    itemsData =itemsData.joins("INNER JOIN users_profiles ON users_profiles.user_id = users_content_items.user_id")
    unless term.blank? 
      seatchTerm = "%"+term.downcase+"%"
      itemsData =itemsData.where("lower(users_profiles.fname) like ? and lower(users_profiles.fname) like ?",seatchTerm,seatchTerm)
    end
    itemsData= itemsData.where ({:is_todo =>true })
    itemsData= itemsData.select("users_profiles.*").uniq.page(page).per(APP_CONFIG["Max_Page"])
    itemsData.each do |item|
      userObj = item
      asset = {
        :id => -1,
        :uri=> ''
      }
      isFollower = false
      if UsersFollows.where({:user_id =>user_id, ref_user_id:item.user_id}).count  != 0
        isFollower =  true
      end
      unless userObj.image_id.nil?
        assetObj =  Assets.find_by_id(userObj.image_id).asset.url(:small)
        asset[:id] = userObj.image_id
        asset[:uri] = assetObj
      end
      objectData = {
        fname: userObj.fname,
        lname: userObj.lname,
        image: {
          id: asset[:id],
          uri: asset[:uri]
        },
        user_id: item.user_id,
        status: {
          isFollower: isFollower
        }
      }
      items.push(objectData)
    end
    objectHash = {
      items: items,
      total: itemsData.num_pages
    }
    objectHash
  end
  def self.getFeelikeMemebers(user_id , item_id , feeling_id,term,page )
    items = Array.new
    itemsData = self.consumeGlobalItemById(item_id).where("users_content_items.feeling_id  is not null and users_content_items.feeling_id = ?",feeling_id)
    
    itemsData =itemsData.joins("INNER JOIN users_profiles ON users_profiles.user_id = users_content_items.user_id")
    unless term.blank? 
      seatchTerm = "%"+term.downcase+"%"
      itemsData =itemsData.where("lower(users_profiles.fname) like ? and lower(users_profiles.fname) like ?",seatchTerm,seatchTerm)
    end
    itemsData= itemsData.where ({:is_feelike => true })
    itemsData= itemsData.select("users_profiles.*").uniq.page(page).per(APP_CONFIG["Max_Page"])
    itemsData.each do |item|
      userObj = item
      asset = {
        :id => -1,
        :uri=> ''
      }
      isFollower = false
      if UsersFollows.where({:user_id =>user_id, ref_user_id:item.user_id}).count  != 0
        isFollower =  true
      end
      unless userObj.image_id.nil? && userObj.image_id == 0
        begin
          assetObj =  Assets.find_by_id(userObj.image_id).asset().url(:small)
          asset[:id] = userObj.image_id
          asset[:uri] = assetObj
        rescue => e
        end
      end
      objectData = {
        fname: userObj.fname,
        lname: userObj.lname,
        image: {
          id: asset[:id],
          uri: asset[:uri]
        },
        user_id: item.user_id,
        status: {
          isFollower: isFollower
        }
      }
      items.push(objectData)
    end
    objectHash = {
      items: items,
      total: itemsData.num_pages
    }
    objectHash
  end

  def self.getRecommendedItems(term,user_id)
  	items = Array.new
   # binding.pry
    itemsData = UsersContentItems.consumeGlobalItemByTerm(term).per(APP_CONFIG["Max_Page"])
  	itemsData.each{|item| items.push(self.scanByType(item,user_id)) } 
  	objectHash = {
      items: items,
      total: itemsData.num_pages
    }
    objectHash
  end
  protected
  def scanByType(item ,user_id) 
    itemData = nil
    userSetttings = UsersSettings.byUser(item.user_id).first
    if user_id == item.user_id
      itemData = self.readItem(item)
    else
      unless userSetttings.is_private_post 
        itemData = self.readItem(item)
      end
    end
    itemData
  end
  def self.scanByType(item  ,user_id) 
    itemData = nil
    userSetttings = UsersSettings.byUser(item.user_id).first
    if user_id == item.user_id
      itemData = self.readItem(item)
    else
      unless userSetttings.is_private_post 
        itemData = self.readItem(item)
      end
    end
    itemData
  end
  private
  def readItem(item) 
    totalTodo = UsersContentItems.consumeGlobalItemById(item.content_item_id).where({:is_todo =>true , :is_feelike => false}).size
    totalFeelike = UsersContentItems.consumeGlobalItemById(item.content_item_id).where({:is_todo =>false , :is_feelike => true}).size
    totalComments = PostsComments.commentByItem(item.content_item_id).size
    conentItem = ContentItem.find_by_id(item.content_item_id)
    exp_name = ''
    exp_id = 0
    postObj = nil

    if item.user_exprance_id.nil?
      postObj =  Posts.where({:user_id => item.user_id,:asset_id => item.asset_id, :feeling_id => item.feeling_id, :content_item_id=>item.content_item_id, :userExprience_id=>0})
    else
      postObj =  Posts.where({:user_id => item.user_id,:asset_id => item.asset_id, :feeling_id => item.feeling_id, :content_item_id=>item.content_item_id, :userExprience_id=>item.user_exprance_id})
    end
    userObj = UsersProfile.byUser(item.user_id).first
    userSetttings = UsersSettings.byUser(item.user_id).first
    asset = {
      :id => -1,
      :uri=> ''
    }
    unless userObj.image_id.nil?
      if userObj.image_id != 0 
        begin
          assetObj =  Assets.find_by_id(userObj.image_id).asset().url(:small)
          asset[:id] = userObj.image_id
          asset[:uri] = assetObj
        rescue
        end
      end
    end
    description = "" 
    if postObj.size != 0 
      description= postObj.first.content
      unless postObj.first.userExprience_id.nil? 
        expRecored = UsersExprience.where({id:postObj.first.userExprience_id})
        exp_name = expRecored.first().name if postObj.first.userExprience_id != 0 && expRecored.size != 0
        exp_id = postObj.first.userExprience_id
      end
    end
    objectData = nil
    unless conentItem.nil?
      objectData = {
        item_id: item.content_item_id,
        name: conentItem.name,
        creator: {
          fname: userObj.fname,
          lname: userObj.lname,
          image: {
            id: asset[:id],
            uri: asset[:uri]
          },
          user_id: item.user_id
        },
        description: description,
        category_id: conentItem.category_id,
        exp_name: exp_name,
        exp_id:exp_id,
        category_name: Categories.active.find_by_id(conentItem.category_id).name,
        category_icon: '',
        totalComments: totalComments,
        created_at: item.created_at.strftime("%m/%d/%Y %H:%M:%S"),
        totalTodo: totalTodo,
        totalFeelike: totalFeelike,
        feeling_id: item.feeling_id,
        asset: '',
        item_data: {},
        content_type: 'youtube'
      }
    else
      assetObject = {
        id: -1 ,
        uri: ""
      }
      assetObj =  Assets.find_by_id(item.asset_id).asset.url(:small)
      assetObject[:id] = item.asset_id
      assetObject[:uri] = assetObj
      objectData = {
        item_id: item.content_item_id,
        name: '',
        creator: {
          fname: userObj.fname,
          lname: userObj.lname,
          image: {
            id: asset[:id],
            uri: asset[:uri]
          },
          user_id: item.user_id
        },
        description: description,
        category_id: 0,
        exp_name: exp_name,
        exp_id:exp_id,
        category_name: 'Images',
        category_icon: '',
        totalComments: totalComments,
        created_at: item.created_at.strftime("%m/%d/%Y %H:%M:%S"),
        totalTodo: totalTodo,
        totalFeelike: totalFeelike,
        feeling_id: item.feeling_id,
        asset: '',
        item_data: assetObject,
        content_type: 'image'
      }
    end
    profile_object = nil
    type = 'youtube'
    image_uri = ''
    unless conentItem.profile_youtube_id.nil?
      profile_object = ContentItemsYoutube.profileByItem(conentItem.profile_youtube_id).first()
      image_uri = profile_object.image_uri
      objectData[:content_type] = 'youtube'
      objectData[:item_data] = {
        embed: profile_object.embed_uri,
        youtube_id: profile_object.youtube_id,
        mobile_uri: profile_object.mobile_uri,
        author: profile_object.author,
        duration: profile_object.duration
      }
      
    end
    unless conentItem.nil? 
      unless conentItem.profile_youtube_id.nil?
        profile_object = ContentItemsYoutube.profileByItem(conentItem.profile_youtube_id).first()
        image_uri = profile_object.image_uri
        objectData[:content_type] = 'youtube'
        objectData[:item_data] = {
          embed: profile_object.embed_uri,
          youtube_id: profile_object.youtube_id,
          mobile_uri: profile_object.mobile_uri,
          author: profile_object.author,
          duration: profile_object.duration
        }
        
      end
      unless conentItem.profile_itunes_id.nil?
        profile_object = ContentItemsItunes.profileByItem(conentItem.profile_itunes_id).first()
        image_uri = profile_object.artwork_uri
        objectData[:content_type] = 'itunes'
        objectData[:item_data] = {
          artist_id: profile_object.artist_id,
          artist_name: profile_object.artist_name,
          artist_view_uri: profile_object.artist_view_uri,
          collectionArt_name: profile_object.collectionArt_name,
          collection_id: profile_object.collection_id,
          collection_price: profile_object.collection_price,
          collection_view_uri: profile_object.collection_view_uri,
          country: profile_object.country,
          currency: profile_object.currency,
          genre: profile_object.genre,
          long_description: profile_object.long_description,
          preview_uri: profile_object.preview_uri,
          track_id: profile_object.track_id,
          track_price: profile_object.track_price,
          track_time_millis: profile_object.track_time_millis,
          track_view_uri: profile_object.track_view_uri
          #type: profile_object.type
        }
        objectData[:asset] = profile_object.track_view_uri
      end
      unless conentItem.profile_amazon_id.nil?
        profile_object = ContentItemsAmazon.profileByItem(conentItem.profile_amazon_id).first()
        image_uri = profile_object.images.first
        objectData[:content_type] = 'amazon'
        objectData[:item_data] = {
          uri: profile_object.uri,
          item_id: profile_object.item_id,
          authors: profile_object.authors,
          ean: profile_object.ean,
          edition: profile_object.edition,
          isbn: profile_object.isbn,
          images: profile_object.images,
          title: profile_object.title,
          studio: profile_object.studio,
          manufacturer: profile_object.manufacturer,
          publish_date: profile_object.publish_date
        }
        objectData[:asset] = profile_object.images
      end
    end
    objectData[:asset] = image_uri
    objectData
  end
  def self.readItem(item) 
    totalTodo = UsersContentItems.consumeGlobalItemById(item.content_item_id).where({:is_todo =>true , :is_feelike => false}).size
    totalFeelike = UsersContentItems.consumeGlobalItemById(item.content_item_id).where({:is_todo =>false , :is_feelike => true}).size
    totalComments = PostsComments.commentByItem(item.content_item_id).size
    conentItem = ContentItem.find_by_id(item.content_item_id)
    exp_name = ''
    exp_id = 0
    postObj = nil

    if item.user_exprance_id.nil?
      postObj =  Posts.where({:user_id => item.user_id,:asset_id => item.asset_id, :feeling_id => item.feeling_id, :content_item_id=>item.content_item_id, :userExprience_id=>0})
    else
      postObj =  Posts.where({:user_id => item.user_id,:asset_id => item.asset_id, :feeling_id => item.feeling_id, :content_item_id=>item.content_item_id, :userExprience_id=>item.user_exprance_id})
    end
    userObj = UsersProfile.byUser(item.user_id).first
    userSetttings = UsersSettings.byUser(item.user_id).first
    asset = {
      :id => -1,
      :uri=> ''
    }
    unless userObj.image_id.nil?
      if userObj.image_id != 0 
        begin
          assetObj =  Assets.find_by_id(userObj.image_id).asset().url(:small)
          asset[:id] = userObj.image_id
          asset[:uri] = assetObj
        rescue
        end
      end
    end
    description = "" 
    if postObj.size != 0 
      description= postObj.first.content
      unless postObj.first.userExprience_id.nil? 
        expRecored = UsersExprience.where({id:postObj.first.userExprience_id})
        exp_name = expRecored.first().name if postObj.first.userExprience_id != 0 && expRecored.size != 0
        exp_id = postObj.first.userExprience_id
      end
    end
    objectData = nil
    unless conentItem.nil?
      objectData = {
        item_id: item.content_item_id,
        name: conentItem.name,
        creator: {
          fname: userObj.fname,
          lname: userObj.lname,
          image: {
            id: asset[:id],
            uri: asset[:uri]
          },
          user_id: item.user_id
        },
        description: description,
        category_id: conentItem.category_id,
        exp_name: exp_name,
        exp_id:exp_id,
        category_name: Categories.active.find_by_id(conentItem.category_id).name,
        category_icon: '',
        totalComments: totalComments,
        created_at: item.created_at.strftime("%m/%d/%Y %H:%M:%S"),
        totalTodo: totalTodo,
        totalFeelike: totalFeelike,
        feeling_id: item.feeling_id,
        asset: '',
        item_data: {},
        content_type: 'youtube'
      }
    else
      assetObject = {
        id: -1 ,
        uri: ""
      }
      assetObj =  Assets.find_by_id(item.asset_id).asset.url(:small)
      assetObject[:id] = item.asset_id
      assetObject[:uri] = assetObj
      objectData = {
        item_id: item.content_item_id,
        name: '',
        creator: {
          fname: userObj.fname,
          lname: userObj.lname,
          image: {
            id: asset[:id],
            uri: asset[:uri]
          },
          user_id: item.user_id
        },
        description: description,
        category_id: 0,
        exp_name: exp_name,
        exp_id:exp_id,
        category_name: 'Images',
        category_icon: '',
        totalComments: totalComments,
        created_at: item.created_at.strftime("%m/%d/%Y %H:%M:%S"),
        totalTodo: totalTodo,
        totalFeelike: totalFeelike,
        feeling_id: item.feeling_id,
        asset: '',
        item_data: assetObject,
        content_type: 'image'
      }
    end
    profile_object = nil
    type = 'youtube'
    image_uri = ''
    unless conentItem.nil? 
      unless conentItem.profile_youtube_id.nil?
        profile_object = ContentItemsYoutube.profileByItem(conentItem.profile_youtube_id).first()
        image_uri = profile_object.image_uri
        objectData[:content_type] = 'youtube'
        objectData[:item_data] = {
          embed: profile_object.embed_uri,
          youtube_id: profile_object.youtube_id,
          mobile_uri: profile_object.mobile_uri,
          author: profile_object.author,
          duration: profile_object.duration
        }
        
      end
      unless conentItem.profile_itunes_id.nil?
        profile_object = ContentItemsItunes.profileByItem(conentItem.profile_itunes_id).first()
        image_uri = profile_object.artwork_uri
        objectData[:content_type] = 'itunes'
        objectData[:item_data] = {
          artist_id: profile_object.artist_id,
          artist_name: profile_object.artist_name,
          artist_view_uri: profile_object.artist_view_uri,
          collectionArt_name: profile_object.collectionArt_name,
          collection_id: profile_object.collection_id,
          collection_price: profile_object.collection_price,
          collection_view_uri: profile_object.collection_view_uri,
          country: profile_object.country,
          currency: profile_object.currency,
          genre: profile_object.genre,
          long_description: profile_object.long_description,
          preview_uri: profile_object.preview_uri,
          track_id: profile_object.track_id,
          track_price: profile_object.track_price,
          track_time_millis: profile_object.track_time_millis,
          track_view_uri: profile_object.track_view_uri
          #type: profile_object.type
        }
        objectData[:asset] = profile_object.track_view_uri
      end
      unless conentItem.profile_amazon_id.nil?
        profile_object = ContentItemsAmazon.profileByItem(conentItem.profile_amazon_id).first()
        image_uri = profile_object.images.first
        objectData[:content_type] = 'amazon'
        objectData[:item_data] = {
          uri: profile_object.uri,
          item_id: profile_object.item_id,
          authors: profile_object.authors,
          ean: profile_object.ean,
          edition: profile_object.edition,
          isbn: profile_object.isbn,
          images: profile_object.images,
          title: profile_object.title,
          studio: profile_object.studio,
          manufacturer: profile_object.manufacturer,
          publish_date: profile_object.publish_date
        }
        objectData[:asset] = profile_object.images
      end
    end
    objectData[:asset] = image_uri
    objectData
  end
end
