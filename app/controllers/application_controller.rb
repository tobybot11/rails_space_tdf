# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #helper :all # include all helpers, all the time
  #helper ApplicationHelper
  include ApplicationHelper
  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :check_authorization
  
  # Pick a unique cookie name to distinquish our session data from others
  #session :session_key => '_rails_space_tdf_session_id' #<- raises deprecation warning
  #request.session_options[:session_key] = "_rails_space_tdf_session_id"
  
  # Check for a valid authorization cookie, possibly logging the userin
  def check_authorization
    authorization_token = cookies[:authorization_token]
    if authorization_token and not logged_in?
      user = User.find_by_authorization_token(authorization_token)
      user.login!(session) if user
    end
  end
  

end
