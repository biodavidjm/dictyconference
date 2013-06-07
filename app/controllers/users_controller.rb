class UsersController < ApplicationController

	skip_before_filter :login_required, :only => [:new,:create]
	include UsersHelper

	# GET /users
	# GET /users.xml
	def index
		if logged_in?
			if is_admin?
				@users = User.all

				respond_to do |format|
					format.html # index.html.erb
					format.xml  { render :xml => @users }
					format.csv {
						buffer = FasterCSV.generate do |csv|
							fields_user = [
								:id,
								:email,
								:first_name,
								:last_name,
							]
							all_fields = fields_user.map{|field| field.to_s}
							csv << all_fields
							for user in @users
								all_data = fields_user.map{|field| value = user.send(field)}
								csv << all_data
							end
						end
						send_data( buffer, :type => 'text/csv; charset=iso-8859-1; header=present', :filename => 'users.csv')
					}
				end
			else
				flash[:notice] = "You need to be an ADMIN to view list of users"
			end
		else
			redirect_to login_path
		end
	end

	# GET /users/1
	# GET /users/1.xml
	def show
		if logged_in?
			@user = User.find(params[:id])
			respond_to do |format|
				format.html # show.html.erb
				format.xml  { render :xml => @user }
			end
		else
			redirect_to login_path
		end 
	end

	# GET /users/new
	# GET /users/new.xml
	def new
		email = params[:user_session][:email] if ! params[:user_session].nil?
		email ||= params[:email]
		password = params[:user_session][:password] if ! params[:user_session].nil?
		@user = User.new(:password=>password, :email=>email )

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @user }
		end
	end

	# GET /users/1/edit
	def edit
		@user = User.find(params[:id])
	end

	# POST /users
	# POST /users.xml
	def create
		@user = User.new(params[:user])
		@user.is_registered = 0
		respond_to do |format|
			if @user.save
				logger.info "Successfully created profile."
				flash[:notice] = "Successfully created profile."
				if session[:where_from] == 'registration'
					format.html { redirect_to(new_registration_path(@user.id)) }
					# format.xml  { render :xml => @user, :status => :created, :location => @user }
				elsif session[:where_from] == 'abstract'
					format.html { render action: "show" }
					# format.html { redirect_to(abstract_path) }
					# format.xml  { render :xml => @user, :status => :created, :location => @user }
				end
				format.xml  { render :xml => @user, :status => :created, :location => @user }
			else
				flash[:notice] = @user.errors
				if session[:where_from] == 'registration'
					# flash[:notice] = @user.errors
					format.html { redirect_to new_registration_path }
					# format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
				else
					# flash[:notice] = @user.errors
					format.html { render :action => 'new' }
					# format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
				end
				format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /users/1
	# PUT /users/1.xml
	def update
		@user = User.find(params[:id])
		@user.attributes = params[:user]
		if session[:where_from] == 'registration'
			@user.is_registered = 1
		end

		if params[:commit] != 'Cancel'
			respond_to do |format|
				if @user.save
					flash[:notice] = "Successfully updated registration"
					logger.info "Successfully updated registration for #{@user.email}"

					if !Rails.env.test?
						# Send confirmation emails to user and the host
						RegistrationConfirmation.update_confirmation_to_host(@user).deliver
						RegistrationConfirmation.update_confirmation_to_user(@user).deliver
					end 

					format.html { redirect_to registration_path(current_user) }
					format.xml  { render :xml => @user, :status => :created, :location => @user }
				else
					logger.info "Unable to update registration."
					format.html { render :action => "edit" }
					format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
				end
			end
		else
			flash[:notice] = "Cancelled"
			redirect_to registration_path(current_user)
		end
	end

	# DELETE /users/1
	# DELETE /users/1.xml
	def destroy
		@user = User.find(params[:id])
		@user.destroy

		respond_to do |format|
			format.html { redirect_to(users_url) }
			format.xml  { head :ok }
		end
	end
end
