class UserSessionsController < ApplicationController
  before_filter :login_required, :only => [:admin]
  helper :all # include all helpers, all the time
  include UserSessionsHelper
  
  def new
    @user_session = UserSession.new
  end
  
  # Display admin login form
  def admin
  end
  
  def create
    flash[:notice] =''
    @user_session = UserSession.new(params[:user_session]);
    has_valid_email = valid_email?(params[:user_session][:email])
    
    has_valid_password = verify_recaptcha
    
    @user = get_user(params[:user_session])
    valid_user = ! @user.nil?
    if valid_user and has_valid_password
      @user_session = UserSession.create(@user) 
    end
    @user_session.save do |result|
      if result
        flash[:notice] = "Successfully logged in."
        logger.info "Successfully logged in user #{params[:user_session][:email]}."
        if is_admin?
          flash[:notice] = "Logged in as admin"
          redirect_to admin_url
        elsif session[:where_from] == 'registration'
          redirect_to new_registration_path
        else
          redirect_to abstracts_path
        end
      elsif ! valid_user and ! has_valid_email
         @user_session.destroy
         flash[:notice] = "Please enter a proper email and password."
         render :action => :new
      elsif has_valid_email and has_valid_password
        # puts session[:where_from]
        # if session[:where_from] = 'registration'
        #   redirect_to(new_registration_path(:email => params[:user_session][:email]))
        # else
          redirect_to(new_user_path(:email => params[:user_session][:email]))
        # end
      else
        flash[:notice] = "Please enter a proper password."
         @user_session.destroy
         render :action => :new
       end
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to login_url
  end
end
