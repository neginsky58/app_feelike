class UsersExprience < ActiveRecord::Base
  belongs_to :users
  attr_accessible :user_id,:image_id,:name,:content, :created_at, :is_private, :is_active , :is_delete
  default_scope where(:is_active => true , :is_delete => false)
  validates :user_id, :presence => true
  def self.getExpienceByUser(user_id,term)
    data = self.where("users_expriences.user_id = ? and users_expriences.name <> ''",user_id)
    unless term.nil?
      term =  "%"+term+"%"
      data =data.where("users_expriences.name like ?",term)
    end
    data
  end
  def self.getExpienceByUserProfile(user_id,cat_id,page)
    items = Array.new
    queItems = self.joins ("left join users_exprience2_categories on users_exprience2_categories.ue_id  = users_expriences.id")
    queItems = queItems.where("users_expriences.user_id = ?" ,user_id)
    if cat_id != 0 
      queItems = queItems.where("users_exprience2_categories.ue_categoy_id = ?", cat_id)
    end 
    queItems = queItems.where("name <> ''").order("users_expriences.created_at desc").page(page).per(APP_CONFIG["Max_Page"])
    queItems.each do |item|
      if user_id == item.user_id
        items.push(getItem(item))
      else
        unless item.is_private
          items.push(getItem(item))
        end
      end
    end
    objectHash = {
      items: items,
      total: queItems.num_pages
    }
    objectHash
  end
  def self.getExpienceByFollowers(user_id,users ,cat_id,exp_search_name,page) 
    items = Array.new
    user_ids = users.map(&:user_id).join(",")
    queItems = self.joins ("left join users_exprience2_categories on users_exprience2_categories.ue_id  = users_expriences.id")
    if user_ids == ''
      queItems = queItems.where("users_expriences.user_id in( ?)" ,user_id)
    else
      queItems = queItems.where("users_expriences.user_id in( ?,?)" , users.map(&:user_id),user_id)
    end
    if cat_id != 0 
      queItems = queItems.where("users_exprience2_categories.ue_categoy_id = ?", cat_id)
    end
    if exp_search_name != ""
      queItems = queItems.where("name like ?", '%'+exp_search_name+'%')
    end

    queItems = queItems.where("name <> ''").order("users_expriences.created_at desc").uniq.page(page).per(APP_CONFIG["Max_Page"])
    queItems.each do |item|
      if user_id == item.user_id
        items.push(getItem(item))
      else
        unless item.is_private
          items.push(getItem(item))
        end
      end
    end
    objectHash = {
      items: items,
      total: queItems.num_pages
    }
    objectHash
  end
  def self.getExpienceByFollowing(user_id,cat_id,exp_search_name,page)
    items = Array.new
    ue_ids = UsersExprienceFollowers.follower(user_id).map(&:users_expriences_id).join(",")
    queItems = self.joins ("left join users_exprience2_categories on users_exprience2_categories.ue_id  = users_expriences.id")
    queItems = queItems.joins ("left join users_exprience_followers on users_exprience_followers.users_expriences_id  = users_expriences.id")
    unless UsersExprienceFollowers.follower(user_id).size == 0
      queItems = queItems.where("users_expriences.user_id = ? or users_exprience_followers.users_expriences_id in ("+ue_ids+")" ,user_id) unless !exp_search_name.blank?
    else
      queItems = queItems.where("users_expriences.user_id = ?" ,user_id) unless !exp_search_name.blank?
    end
    if cat_id != 0 
      queItems = queItems.where("users_exprience2_categories.ue_categoy_id = ?", cat_id)
    end 
    unless  exp_search_name.blank?
      searchTerm = "%" + exp_search_name + "%"
      queItems = queItems.where("name like ?" , searchTerm)
    end
    queItems = queItems.where("name <> ''").order("users_expriences.created_at desc").uniq.page(page).per(APP_CONFIG["Max_Page"])
    queItems.each do |item|
      
      if user_id == item.user_id
        items.push(getItem(item))
      else
        unless item.is_private
          items.push(getItem(item))
        end
      end
    end
    objectHash = {
      items: items,
      total: queItems.num_pages
    }
    objectHash
  end
  def getExpienceByProfile(type,user_id,page) 
    items = Array.new
    itemsData = Array.new
    userObj = UsersProfile.byUser(self.user_id).first
    imageUrl = ''
    unless self.image_id.nil? 
      imageUrl = Assets.find_by_id(self.image_id).asset.url(:expBanner)
    end
    asset = {
      :id => -1,
      :uri=> ''
    }
    unless userObj.image_id.nil?
      assetObj =  Assets.find_by_id(userObj.image_id).asset.url(:small)
      asset[:id] = userObj.image_id
      asset[:uri] = assetObj
    end

    queItems = nil
    case type
    when 'all'
      queItems = UsersContentItems.consumeGlobalItemAllByUEID(self.id).order("users_content_items.created_at desc")
    when 'music'
      queItems = UsersContentItems.consumeGlobalItemMusicByUEID(self.id).order("users_content_items.created_at desc")
    when 'book'
      queItems = UsersContentItems.consumeGlobalItemBooksByUEID(self.id).order("users_content_items.created_at desc")
    when 'rest'
      queItems = UsersContentItems.consumeGlobalItemRestByUEID(self.id).order("users_content_items.created_at desc")
    when 'hangout'
      queItems = UsersContentItems.consumeGlobalItemHangoutByUEID(self.id).order("users_content_items.created_at desc")
    when 'movies'
      queItems = UsersContentItems.consumeGlobalItemMoviesByUEID(self.id).order("users_content_items.created_at desc")
    when 'images'
      queItems = UsersExprienceImages.byExp(self.id)
    else
      queItems = UsersContentItems.consumeGlobalItemAllByUEID(self.id).order("users_content_items.created_at desc")
    end
    queItems =queItems.page(page).per(APP_CONFIG["Max_Page"])
    queItems.each do |item|
      asset = {
        :id => -1,
        :uri=> ''
      }
      user = {
        :id => -1,
        :fname=> '',
        :lname=> ''
      }
      dataObject = nil
      if type != 'images'
        dataObject = UsersContentItems.get(item,user_id)
      else
        dataObject = {
          :smallUri => '',
          :bigUri => '',
          :id => -1
        }
        unless item.image_id.nil?
          smallAssetObj =  Assets.find_by_id(userObj.image_id).asset.url(:expSmallImage)
          bigAssetObj =  Assets.find_by_id(userObj.image_id).asset.url(:expBigImage)
          dataObject[:id] = item.image_id
          dataObject[:smallUri] = smallAssetObj
          dataObject[:bigUri] = bigAssetObj
        end
      end
      itemsData.push(dataObject)
    end
    is_follow = false
    is_follow = UsersExprienceFollowers.isExists(self.id,user_id)
    responstObject = {
      id: self.id,
      asset: imageUrl,
      name: self.name,
      content: self.content,
      is_follow: is_follow,
      totalFollowers: UsersExprienceFollowers.following(self.id).size,
      totalParticipants: UsersExprienceParticipants.where({user_exp_id: self.id}).size,
      totalMusic: UsersContentItems.consumeGlobalItemMusicByUEID(self.id).size,
      totalBooks: UsersContentItems.consumeGlobalItemBooksByUEID(self.id).size,
      totalRests: UsersContentItems.consumeGlobalItemRestByUEID(self.id).size,
      totalHangout: UsersContentItems.consumeGlobalItemHangoutByUEID(self.id).size,
      totalMovies: UsersContentItems.consumeGlobalItemMoviesByUEID(self.id).size,
      totalImages: UsersExprienceImages.byExp(self.id).size,
      user: {
        id:self.user_id ,
        fname: userObj.fname,
        lname: userObj.lname,
        image: asset
      },
      items: itemsData,
      total: queItems.num_pages
    }
    responstObject
  end
  def getAll(page) 
    items = Array.new
    ueItems = UsersExprience.where({id: params[:ue_id].to_i}).page(params[:page].to_i).per(APP_CONFIG["Max_Page"])
    ueItems.each do |item|
      
      if user_id == item.user_id
        items.push(getItem(item))
      else
        unless item.is_private
          items.push(getItem(item))
        end
      end
    end
    objectHash = {
      items: items,
      total: ueItems.num_pages
    }
    objectHash
  end
  def self.isExists(id)
    if self.where(:id => id).size ==1 
      false
    else
      true
    end
  end
  private 
  def self.getItem(item)
    totalFollowers = UsersExprienceFollowers.following(item.id).size
    totalMusicItems = UsersContentItems.consumeGlobalItemMusicByUEID(item.id).size
    totalBooksItems = UsersContentItems.consumeGlobalItemBooksByUEID(item.id).size
    totalRestItems = UsersContentItems.consumeGlobalItemRestByUEID(item.id).size
    totalHangoutItems = UsersContentItems.consumeGlobalItemHangoutByUEID(item.id).size
    totalMoviesItems = UsersContentItems.consumeGlobalItemMoviesByUEID(item.id).size
    totalImagesItems = UsersExprienceImages.byExp(item.id).size
    userObj = UsersProfile.byUser(item.user_id).first
    imageUrl = ''
    unless item.image_id.nil? 
      imageUrl = Assets.find_by_id(item.image_id).asset.url(:expBanner)
    end
    asset = {
      :id => -1,
      :uri=> ''
    }
    unless userObj.image_id.nil?
      assetObj =  Assets.find_by_id(userObj.image_id).asset.url(:small)
      asset[:id] = userObj.image_id
      asset[:uri] = assetObj
    end
    dataObject = {
      id: item.id,
      asset: imageUrl,
      name: item.name,
      content: item.content,
      totalFollowers: totalFollowers,
      totalMusic: totalMusicItems,
      totalBooks: totalBooksItems,
      totalRests: totalRestItems,
      totalHangout: totalHangoutItems,
      totalMovies: totalMoviesItems,
      totalImages: totalImagesItems,
      user: {
        id:item.user_id ,
        fname: userObj.fname,
        lname: userObj.lname,
        image: asset
      }
    }
    dataObject
  end
end
