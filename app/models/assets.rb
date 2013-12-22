class Assets < ActiveRecord::Base
  attr_accessible :asset,:asset_content_type, :asset_file_name, :asset_file_size
  
  has_attached_file :asset, :styles => { 
  	:small => "150x150!" ,
    :expBanner => "620x200!",
    :expBigImage => "308X308!",
    :expSmallImage => "148X148!"
  },
  :storage => :s3,
  :s3_credentials => "#{Rails.root}/config/s3.yml",
  :s3_protocol => "https",
  :path => "uploads/:style/:id_:hash.:extension",
 # :url  => :s3_eu_url ,
  :hash_secret => "longSecretString"
	validates :asset, :attachment_presence => true
  validates_attachment_size :asset, :less_than => 100.megabytes
  validates_attachment_content_type :asset, :content_type => ['image/jpeg','image/gif', 'image/png']
end
