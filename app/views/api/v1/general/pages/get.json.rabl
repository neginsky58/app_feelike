object @responseObject => :response
extends 'api/v1/base/index'
child :objectData => :data do |response|
  attributes :id, :name,:title, :content,:is_published
end