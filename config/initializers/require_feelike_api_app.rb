Dir[Rails.root + 'lib/Api/*.rb'].each do |file|
  require file
end