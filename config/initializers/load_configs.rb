APP_CONFIG = YAML.load_file("#{Rails.root}/config/feelike.yml")[Rails.env] #will load the feelike env local configs
API_CODE_ERRORS = YAML.load_file("#{Rails.root}/config/api_error_code.yml")#will load the feelike env local configs
#RestClient.log = Rails.root + '/log/agent-api.log'

API_LOOGER = Logger.new("#{Rails.root}/log/api.log")
API_LOOGER_ERR = Logger.new("#{Rails.root}/log/api-err.log")