 class UserSessionsController < ApplicationController
  skip_before_filter :login_required, :only => [:admin]
  helper :all # include all helpers, all the time
  include UserSessionsHelper
  
  def new
    @user_session = UserSession.new
  end
  
  # Display admin login form
  def admin
  end
  
  def create
    @user = get_user(params[:user_session])
    session[:email] = params[:user_session][:email]
    # sorry dude,  you need to register before you break in
    if @user.nil?
        if session[:where_from] == 'registration' or session[:where_from] == 'abstract'
        	flash[:notice] = "#{params[:user_session][:email]} is not registered"
          redirect_to new_registration_path
				else
					flash[:notice] = "Please try to register or submit an abstract first"
					redirect_to root_url
				end
		else
    	@user_session = UserSession.new(@user) 
    	has_valid_email = valid_email?(params[:user_session][:email])
    	has_valid_password = verify_recaptcha

    	if has_valid_email and has_valid_password
    	  # The user has invaded,  lets decide on his next stop
		 		if @user_session.save 
        	flash[:notice] = "Successfully logged in."
        	logger.info "Successfully logged in user #{params[:user_session][:email]}."
        	# if somebody did a half hearted registration
        	if session[:where_from] == 'registration'
        		if is_registered?
          	  redirect_to registration_path(:id => @user.id)
          	else
          		redirect_to new_registration_path
          	end
        	else
          	if is_admin?
            	flash[:notice] = "Logged in as admin"
            	redirect_to admin_url
          	else
            	redirect_to abstracts_path
          	end
        	end
      	else
      		logger.info 'Login failed !!!'
        	flash[:notice] = "Unable to login with #{params[:user_session][:email]},  Please try again"
        	render :action => :new
      	end
       else
         logger.info 'invalid user name and password'
         flash[:notice] = 'Invalid email and/or password,  Please try again'
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
