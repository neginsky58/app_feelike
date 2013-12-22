class UsersProfile < ActiveRecord::Base
  include Paperclip::Glue
	scope :byUser, lambda { |user| where("user_id = ?", user) }
  belongs_to :users
  belongs_to :family_genders
  attr_accessible :user_id, :family_gender_id,:gender,:bio, :birthDate, :fname, :image_id, :lname
  validates :lname, :presence => true
  validates :fname, :presence => true
  #validates :birthDate, :presence => true

  #will update the settings
  def updateProfile(data)
    self.bio = data[:bio].to_s
    self.birthDate = Date.strptime( data[:bdate], '%m/%d/%Y')
    self.lname = data[:lname]
    self.fname = data[:fname]
    self.gender = data[:gender]
    self.image_id = data[:asset_id].to_i
    self.family_gender_id = data[:familyStatus].to_i
    self.save
  end
end
