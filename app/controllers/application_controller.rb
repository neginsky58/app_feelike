class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include ApplicationHelper
  protect_from_forgery

end
