object @responseObject => :response
attributes :status , :code  , :errors ,:timestamp
child :errors do
  attributes :message
end