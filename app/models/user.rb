class User < ActiveRecord::Base
  rolify
	has_one :users_settings, :dependent => :destroy
	has_one :users_profiles, :dependent => :destroy
	has_one :users_socals , :dependent => :destroy
	has_many :users_content_items, :dependent => :destroy
	has_many :users_answers, :dependent => :destroy
	has_many :users_expriences, :dependent => :destroy
	has_many :users_exprience_images, :dependent => :destroy
	has_many :posts, :dependent => :destroy
	has_many :users_exprience_participants, :dependent => :destroy
	has_many :users_follows, :dependent => :destroy
	default_scope where(:is_active => true)
	scope :global , (lambda do |userTerm|
		searchStr = sprintf("users_profiles.fname like '%s' or users_profiles.lname like '%s'"  ,'%'+userTerm+'%','%'+userTerm+'%') unless userTerm.nil?
		select('users.*,users_profiles.*, family_genders.name as familyStatus,users_settings.*')
		.joins("INNER JOIN users_profiles ON users_profiles.user_id = users.id")
		.joins("INNER JOIN users_settings ON users_settings.user_id = users.id")
		.joins("left JOIN family_genders ON users_profiles.family_gender_id = family_genders.id")
		.where (searchStr) unless userTerm.nil?
	end)
	scope :byId , (lambda do |user_id|
		select('users.*,users_profiles.*, family_genders.name as familyStatus,users_settings.*')
		.joins("INNER JOIN users_profiles ON users_profiles.user_id = users.id")
		.joins("INNER JOIN users_settings ON users_settings.user_id = users.id")
		.joins("left JOIN family_genders ON users_profiles.family_gender_id = family_genders.id")
		.where("users.id = ?" ,user_id) 
	end)
	scope :followers ,(lambda do |userTerm| 
		searchStr = sprintf("users_profiles.fname like '%s' or users_profiles.lname like '%s'"  ,'%'+userTerm+'%','%'+userTerm+'%') unless userTerm.nil?
		select('users.*,users_profiles.*, family_genders.name as familyStatus,users_settings.*')
		.joins("INNER JOIN users_profiles ON users_profiles.user_id = users.id")
		.joins("INNER JOIN users_settings ON users_settings.user_id = users.id")
		.joins("left JOIN family_genders ON users_profiles.family_gender_id = family_genders.id")
		.joins("INNER JOIN users_follows ON users_follows.user_id = users.id")
		.where (searchStr) unless userTerm.nil?
	end)

	scope :following ,(lambda do |userTerm| 
		searchStr = sprintf("users_profiles.fname like '%s' or users_profiles.lname like '%s'"  ,'%'+userTerm+'%','%'+userTerm+'%') unless userTerm.nil?
		select('users.*,users_profiles.*, family_genders.name as familyStatus,users_settings.*')
		.joins("INNER JOIN users_profiles ON users_profiles.user_id = users.id")
		.joins("INNER JOIN users_settings ON users_settings.user_id = users.id")
		.joins("left JOIN family_genders ON users_profiles.family_gender_id = family_genders.id")
		.joins("INNER JOIN users_follows ON users_follows.ref_user_id = users.id")
		.where (searchStr) unless userTerm.nil?
	end)
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable,:token_authenticatable
	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me, :is_active,:provider, :uid,:authentication_token,:password_reset_sent_at

	def self.canAddFollwer(ref_user_id) 
		user = User.find_by_id(ref_user_id)
		user.nil?
	end
	def self.getAllUsers(user_id,is_add_following,term,page) 
		users = User.global(term)
    if is_add_following.to_i == 1
    	user_ids =  UsersFollows.following(user_id).map(&:ref_user_id).join(",")
      users =  users.where("users.id not in (" + user_ids + ")") unless UsersFollows.following(user_id).size == 0
    end
    users = users.uniq.page(page).per(APP_CONFIG["Max_Page"])
    usersProfile = Array.new
    users.each do |item|
      userObj = UsersProfile.byUser(item.id).first
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
		      rescue => e
		      end
	      end
      end
      #is_follow = UsersFollows.isExists(item.id,user_id)
      dataHash ={
        fname: userObj.fname,
        lname: userObj.lname,
        id: item.id,
        image: asset
      }
      usersProfile.push(dataHash)
    end
    objectHash = {
      items: usersProfile,
      total: users.num_pages
    }
    objectHash
	end
	#check for matchs in the db if true send alert 
	def self.isUserExist(email)
		userMatch = self.where(:email => email).limit(1)
		if userMatch.length ==1 
			false
		else
			true
		end
	end
	#check for matchs in the db if true send alert 
	def self.isUserExistById(user_id)
		userMatch = self.where(:id => user_id).first()
		userMatch.nil?
	end
	#will get all the user object include what there is in the profile as well in the settings
	def self.getFullUserData(id) 
		userObject = self.select('users.*,users_profiles.*, family_genders.name as familyStatus,users_settings.*')
		.joins("INNER JOIN users_profiles ON users_profiles.user_id = users.id")
		.joins("INNER JOIN users_settings ON users_settings.user_id = users.id")
		.joins("left JOIN family_genders ON users_profiles.family_gender_id = family_genders.id")
		.where({
			:users =>{:id => id}
		}).first
		#:id , :email , :fname , :lname , :gender , :asset ,:bio , :bdate ,:family_gender_id
	
    asset = {
      :id => -1,
      :uri=> ''
    }
    userProfileObject = UsersProfile.byUser(id).first
    unless userProfileObject.image_id.nil?   
    	if userProfileObject.image_id.to_i != 0
    		begin
	        assetObj =  Assets.find_by_id(userProfileObject.image_id).asset().url(:small)
	        asset[:id] = userProfileObject.image_id
	        asset[:uri] = assetObj
	      rescue => e
	      end
	    end
    end
		dataObject = {
			:user_id => userObject.id,
			:fname => userProfileObject.fname,
			:lname => userProfileObject.lname,
			:email => userObject.email,
			:bio => userProfileObject.bio,
			:bdate => userProfileObject.birthDate.strftime("%m/%d/%Y"),
			:gender => userProfileObject.gender,
			:family_gender_id => userProfileObject.family_gender_id,
			:asset => asset,
			:authentication_token => userObject.authentication_token
		}
		dataObject
	end
	#will do register for new user
	def self.register(data = {}) 
		familyGender = nil
		familyGenderID = 1
		if data[:familyStatus].to_i == -1
			familyGender =  FamilyGender.find_by_id(data[:familyStatus].to_i)
			familyGenderID = familyGender.id
		end
		#we create user data row
		userObject = self.new({
			:email => 									data[:email] ,  
			:password => 								data[:password] , 
			:password_confirmation => 	data[:password_confirmation]
		})
		userObject.save
		#we create user profile row 
		userProfile = UsersProfile.new({
			:user_id => 						userObject.id,
			:family_gender_id => 		familyGenderID,
			:fname => 							data[:fname],
			:lname => 							data[:lname],
			:gender =>							data[:gender],
			:birthDate =>						data[:bdate],
			:bio	=>								'',
			:image_id =>						data[:image_id]
		})
		userProfile.save!
		userSettings = UsersSettings.new({
			:user_id => 								userObject.id,
			:comment_status =>				2,
			:feelike_status =>			2,
			:experience_status	=>			2,
			:experience_p_status	  =>			2,
			:follows_status			=>			2,
			:is_private_post			=>			false,
			:mobile_token => data[:mobileToken]
		})
		userSettings.save!
    userObject.ensure_authentication_token
    UsersSocals.create({
    	:users_id=> userObject.id,
    	:facebook_token => '' ,
    	:has_facebook => false, 
    	:has_twitter => false, 
    	:twitter_token => ''
    })
    userObject.save
    begin
    	Api::V1::Mailer::NotificationMailer.deliver_register(data[:email]  , data[:fname] + " , " + data[:lname]).deliver
    rescue
    end
    userObject

	end
	def send_password_reset
		self.generate_reset_password_token
		self.send_reset_password_instructions
	end

	def getFbFriendsList () 
		friends_list = Array.new
		user_socal_obj = UsersSocals.byUser(self.id).first()
		@graph = Koala::Facebook::API.new(user_socal_obj.facebook_token)
		friends = @graph.get_connections("me", "friends")
		friends.each do |item|
			unless item["id"].to_i == 0
				fb_item = UsersSocals.byFbID(item["id"].to_i).first
				if fb_item.nil? 
					friends_list.push({id: item["id"].to_i , name: item["name"].to_s})
				end
			end
		end
		friends_list
	end
	
	def self.locateSocalToken(type  ,fb_id,token)
		userObject = nil
		user_socal_object = nil
		case type
		when 'facebook'
			begin 
				@graph = Koala::Facebook::API.new(token)
				@graph.get_connections("koppel", "likes") #lets check for some user private data that the token is working if not will be kill the connection
				user_socal_object = UsersSocals.byTokenFacebook(token)
				if user_socal_object.nil?
					user_socal_object = UsersSocals.byFbID(fb_id).connectFacebook(fb_id,token)
					user_socal_object.connectFacebook(fb_id,token)
				end
			rescue Koala::Facebook::GraphAPIError => e
			end
		when 'twitter' 
			user_socal_object = UsersSocals.byTokenTwitter(token)
		end
		if user_socal_object.count != 0
			userObject = User.where("id = ?",user_socal_object.first().users_id).first()
		end
		userObject
	end

	def connectSocal(type ,fb_id , token)
		case type
		when 'facebook'
			UsersSocals.byUser(self.id).first().connectFacebook(fb_id,token)
		when 'twitter' 
			UsersSocals.byUser(self.id).first().connectTwittwer(token)
		end
	end

	def unConnectSocal(type )
		case type
		when 'facebook'
			UsersSocals.byUser(self.id).first().unConnectFacebook()
		when 'twitter' 
			UsersSocals.byUser(self.id).first().unConnectTwittwer()
		end
	end
end