PaperclipConfig = YAML.load_file("#{Rails.root}/config/paperclip.yml")[Rails.env]
#Paperclip::Attachment.default_options[:storage] = :fog
#Paperclip::Attachment.default_options[:fog_credentials] = {:provider => "Local", :local_root => "#{Rails.root}/public/uploads/"}
#Paperclip::Attachment.default_options[:fog_directory] = ""
#Paperclip::Attachment.default_options[:fog_host] = PaperclipConfig['host']
Paperclip::Attachment.default_options[:url] = ':s3_eu_url'