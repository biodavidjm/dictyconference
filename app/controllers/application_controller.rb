class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include ApplicationHelper

  protect_from_forgery
   
  helper_method :current_user
  
  # before_filter  :login_required, :except => :login 

  private

  def login_required
    if ! logged_in?
       flash[:notice] ||= 'Please login or create a new profile.'
       redirect_to( login_url ) 
    end
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

end
