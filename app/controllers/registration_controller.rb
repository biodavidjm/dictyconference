class RegistrationController < ApplicationController
	#current_tab :registration
  before_filter :login_required, :only => [:new,:create]

	def index
		@users = User.all
    session[:where_from] = 'registration'
	end

=begin
rescue Exception => e 
=end
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

=begin
rescue Exception => e
=end
	def create
		@user = User.new(params[:user])
     	respond_to do |format|
      		if @user.save 
          		logger.info "Registration successful"
          		flash[:notice] = "Registration successful !"
              format.html { render :action => "view" }
      		else
          		flash[:notice] = @user.errors
          		format.html { render :action => "new" }
          		format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      		end
      	end
  	end

def edit
    @user = User.find(params[:id])
end

=begin
rescue Exception => e	
=end
	def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
	end

=begin
rescue Exception => e	
=end
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
	end

	def update
    @user = User.find(params[:id])
    @user.attributes = params[:user]
    
    respond_to do |format|
      if @user.save
        flash[:notice] = "Successfully updated profile."
        logger.info "Successfully updated profile."
        format.html { redirect_to registration_path }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        logger.info "Unable to update profile."
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
	end

end
