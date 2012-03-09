class RegistrationController < ApplicationController
	#current_tab :registration
	skip_before_filter :login_required, :only => [:new,:create]

	def index
		@users = User.all
	end

	def new
		# @user = User.new
		email = params[:user_session][:email] if ! params[:user_session].nil?
    	email ||= params[:email] 
    	password = params[:user_session][:password] if ! params[:user_session].nil?
    	@user = User.new(:password=>password, :email=>email )

    	 respond_to do |format|
       		format.html # new.html.erb
       		format.xml  { render :xml => @user }
    	 end
	end

	def create
		@register = User.new(params[:user])
     	respond_to do |format|
      		if @register.save 
          		logger.info "Registration successful"
          		flash[:notice] = "Registration successful !"
      		else
          		flash[:notice] = @register.errors
          		# format.html { render :action => "new" }
          		format.xml  { render :xml => @register.errors, :status => :unprocessable_entity }
      		end
      	end
  	end

=begin
rescue Exception => e	
=end
	def destroy
	end

=begin
rescue Exception => e	
=end
	def show
		@register = User.find(params[:id])
    	respond_to do |format|
      		format.html # show.html.erb
      		format.xml  { render :xml => @register }
    	end
	end

	def update
    email = params[:user_session][:email] if ! params[:user_session].nil?
    # @register = User.new (:email => email)
	end

end
