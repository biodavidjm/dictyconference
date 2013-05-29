class UserSessionsController < ApplicationController
	skip_before_filter :login_required, :only => [:admin]
	#helper :all # include all helpers, all the time
	include UserSessionsHelper, UsersHelper

	def new
		@user_session = UserSession.new
	end

	def admin
	end

	def create
		@user = get_user(params[:user_session])
		session[:email] = params[:user_session][:email]

		has_valid_email = valid_email?(params[:user_session][:email])
		has_valid_password = verify_recaptcha

		if !has_valid_email or !has_valid_password
			logger.info 'Invalid user name and password'
			flash[:notice] = 'Invalid email and/or password,  Please try again'
			@user_session = UserSession.new
			render :action => :new
		else
			if @user.nil?
				if session[:where_from] == 'registration'
					if !is_registered?
						flash[:notice] = "You are not registered"
						redirect_to new_registration_path
					else
						flash[:notice] = "You are already registered with #{params[:user_session][:email]}"
						redirect_to registration_path(:id => @user.id)
					end
				elsif session[:where_from] == 'abstract'
					flash[:notice_error] = "Please try to register or submit an abstract first"
					#redirect_to root_url
					redirect_to new_user_path
				end
			else
				@user_session = UserSession.new(@user)
				if @user_session.save
					logger.info "Successfully logged in user #{params[:user_session][:email]}."
					# if somebody did a half hearted registration
					if session[:where_from] == 'registration'
						if is_registered?
							flash[:notice] = "You are already registered with #{params[:user_session][:email]}"
							redirect_to registration_path(:id => @user.id)
						elsif !is_registered? and @user.email.empty? == false
							flash[:notice] = "You are NOT registered, but your account exists with email #{params[:user_session][:email]}"
							redirect_to edit_registration_path(:id => @user.id)
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
					flash[:notice_error] = "Unable to login with #{params[:user_session][:email]},  Please try again"
					render :action => :new
				end
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
