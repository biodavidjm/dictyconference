class RegistrationController < ApplicationController
	#current_tab :registration
	before_filter :login_required, :only => [:new,:create,:update]

	def index
		@users = User.all
    session[:where_from] = 'registration'
	end

	def new
		# @user = User.new
		email = params[:user_session][:email] if ! params[:user_session].nil?
    email ||= params[:email] 
    password = params[:user_session][:password] if ! params[:user_session].nil?
    @user = User.new(:email=>email)

    	respond_to do |format|
       	format.html # new.html.erb
       	format.xml  { render :xml => @user }
    	end
	end

	def create
		@user = User.new(params[:user])
     	respond_to do |format|
      		if @user.save 
          		logger.info "Registration successful"
          		flash[:notice] = "Registration successful !"
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
    email = params[:user_session][:email] if ! params[:user_session].nil?
    # @register = User.new (:email => email)
	end

end
