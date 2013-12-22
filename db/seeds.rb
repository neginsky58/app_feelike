# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# sees the family tieds
if FamilyGender.count == 0
  puts "Creating Family Genders"
	FamilyGender.create!({name: 'No Status'})
	FamilyGender.create!({name: 'Single'})
	FamilyGender.create!({name: 'In a Relationship'})
	FamilyGender.create!({name: 'Engaged'})
	FamilyGender.create!({name: 'Married'})
	FamilyGender.create!({name: 'Its Complicated'})
	FamilyGender.create!({name: 'In an Open Relationship'})
	FamilyGender.create!({name: 'Widowed'})
	FamilyGender.create!({name: 'Separated'})
	FamilyGender.create!({name: 'Divorced'})
end
if UsersExprienceCategories.count == 0
	puts "Creating Users Exprience Categories"
	puts "Creating Users Exprience Category holiday Tags"
	holiday = UsersExprienceCategories.new({name: 'Holiday'})
	holiday.save!
	holiday_item_01 = UsersExprienceCategoriesTags.new({name: 'Christmas'})
	holiday_item_01.save!
	UsersExprienceCategories2Tags.create({cat_id:holiday.id , cat_tag_id:holiday_item_01.id})
	holiday_item_02 = UsersExprienceCategoriesTags.new({name: 'Easter'})
	holiday_item_02.save!
	UsersExprienceCategories2Tags.create({cat_id:holiday.id , cat_tag_id:holiday_item_02.id})
	holiday_item_03 = UsersExprienceCategoriesTags.new({name: 'Hanukkah'})
	holiday_item_03.save!
	UsersExprienceCategories2Tags.create({cat_id:holiday.id , cat_tag_id:holiday_item_03.id})
	holiday_item_04 = UsersExprienceCategoriesTags.new({name: 'Eve'})
	holiday_item_04.save!
	UsersExprienceCategories2Tags.create({cat_id:holiday.id , cat_tag_id:holiday_item_04.id})
	holiday_item_05 = UsersExprienceCategoriesTags.new({name: 'Holiday'})
	holiday_item_05.save!
	UsersExprienceCategories2Tags.create({cat_id:holiday.id , cat_tag_id:holiday_item_05.id})
	holiday_item_06 = UsersExprienceCategoriesTags.new({name: 'Columbus'})
	holiday_item_06.save!
	UsersExprienceCategories2Tags.create({cat_id:holiday.id , cat_tag_id:holiday_item_06.id})
	holiday_item_07 = UsersExprienceCategoriesTags.new({name: 'Thanksgiving'})
	holiday_item_07.save!
	UsersExprienceCategories2Tags.create({cat_id:holiday.id , cat_tag_id:holiday_item_07.id})

	puts "Creating Users Exprience Category party Tags"
	party = UsersExprienceCategories.create!({name: 'Party'})

	puts "Creating Users Exprience Category drive Tags"
	drive = UsersExprienceCategories.create!({name: 'Drive'})

	puts "Creating Users Exprience Category summer Tags"
	summer = UsersExprienceCategories.create!({name: 'Summer'})

	puts "Creating Users Exprience Category spring Tags"
	spring = UsersExprienceCategories.create!({name: 'Spring'})

	puts "Creating Users Exprience Category run Tags"
	run = UsersExprienceCategories.create!({name: 'Run'})

	puts "Creating Users Exprience Category wild Tags"
	wild = UsersExprienceCategories.create!({name: 'Wild'})

	puts "Creating Users Exprience Category dance Tags"
	dance = UsersExprienceCategories.create!({name: 'Dance'})

	puts "Creating Users Exprience Category rain Tags"
	rain = UsersExprienceCategories.create!({name: 'Rain'})

	puts "Creating Users Exprience Category sleepy Tags"
	sleepy = UsersExprienceCategories.create!({name: 'Sleepy'})

	puts "Creating Users Exprience Category intimacy Tags"
	intimacy = UsersExprienceCategories.create!({name: 'Intimacy'})

	puts "Creating Users Exprience Category bored Tags"
	bored = UsersExprienceCategories.create!({name: 'Bored'})

	puts "Creating Users Exprience Category travel Tags"
	travel = UsersExprienceCategories.create!({name: 'Travel'})

	puts "Creating Users Exprience Category sporty Tags"
	sporty = UsersExprienceCategories.create!({name: 'Sporty'})

	puts "Creating Users Exprience Category romantic Tags"
	romantic = UsersExprienceCategories.create!({name: 'Romantic'})

	puts "Creating Users Exprience Category flower Tags"
	flower = UsersExprienceCategories.create!({name: 'Flower'})

	puts "Creating Users Exprience Category beauty Tags"
	beauty = UsersExprienceCategories.create!({name: 'Beauty'})

	puts "Creating Users Exprience Category kids Tags"
	kids = UsersExprienceCategories.create!({name: 'Kids'})

	puts "Creating Users Exprience Category cartoon Tags"
	cartoon = UsersExprienceCategories.create!({name: 'Cartoon'})

	puts "Creating Users Exprience Category lonely Tags"
	lonely = UsersExprienceCategories.create!({name: 'Lonely'})

	puts "Creating Users Exprience Category sadness Tags"
	sadness = UsersExprienceCategories.create!({name: 'Sadness'})

	puts "Creating Users Exprience Category history Tags"
	history = UsersExprienceCategories.create!({name: 'History'})
end
if Feelings.count == 0
  puts "Creating Feelings"
	Feelings.create!({name: "Suprised" ,hex: '#fffff' })
	Feelings.create!({name: "Crazy" ,hex: '#fffff' })
	Feelings.create!({name: "Excited" ,hex: '#fffff' })
	Feelings.create!({name: "Fall in love" ,hex: '#fffff'})
	Feelings.create!({name: "Cry" ,hex: '#fffff'})
	Feelings.create!({name: "Shiver" ,hex: '#fffff' })
	Feelings.create!({name: "Mystery" ,hex: '#fffff' })
	Feelings.create!({name: "Nostalgic" ,hex: '#fffff' })
	Feelings.create!({name: "Laugh" ,hex: '#fffff' })
	Feelings.create!({name: "Dream" ,hex: '#fffff'})
	Feelings.create!({name: "Relax" ,hex: '#fffff'})
	Feelings.create!({name: "Contemplative" ,hex: '#fffff'})
	Feelings.create!({name: "Philosophical" ,hex: '#fffff'})
	Feelings.create!({name: "Sophisticated" ,hex: '#fffff'})
	Feelings.create!({name: "Spirital" ,hex: '#fffff'})
end
youtube = nil
itunes = nil
music = nil
books = nil
movie = nil
if ProviderCategories.count == 0 
  puts "Creating ProviderCategories"
	youtube = ProviderCategories.new({name: 'Music', provider_name:'youtube' , is_active:true})
	youtube.save!
	itunes = ProviderCategories.new({name: 'Movie', provider_name:'itunes' , is_active:true})
	itunes.save!
end
if Categories.count == 0 
  puts "Creating Categories"
	music =Categories.new({name: 'Music' , is_active:true})
	music.save!
	books =Categories.new({name: 'Books' , is_active:true})
	books.save!
	movie =Categories.new({name: 'Movie' , is_active:true})
	movie.save!
end
puts "Binding Categories to providers"
if Categories2ProviderCategories.count == 0
	
	Categories2ProviderCategories.create!({categories_id: music.id , provider_categories_id:youtube.id})
	Categories2ProviderCategories.create!({categories_id: movie.id , provider_categories_id:itunes.id})
	puts "Saving binding"
end
if Params.count == 0 
  puts "Creating Params  Settings Table"
end
if UserExpiranceAccessTypes.count == 0 
  puts "Creating User Expirance Access Types Table"
  UserExpiranceAccessTypes.create!({name: 'create'})
  UserExpiranceAccessTypes.create!({name: 'comment'})
  UserExpiranceAccessTypes.create!({name: 'post'})
end
if NotificationsStatus.count == 0
	puts "Creating Notifications Status Table"
	NotificationsStatus.create({is_following: true , is_ue_following:false , is_ue_p: false , is_feelike:false})
	NotificationsStatus.create({is_following: false , is_ue_following:true , is_ue_p: false , is_feelike:false})
	NotificationsStatus.create({is_following: false , is_ue_following:false , is_ue_p: true , is_feelike:false})
	NotificationsStatus.create({is_following: false , is_ue_following:false , is_ue_p: false , is_feelike:true})
end