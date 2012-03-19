class RegistrationController < ApplicationController
	#current_tab :registration
   
  def index
    session[:where_from] = 'registration'
  end

  def new
    logger.info 'User is ***not*** registered'
      @user = User.new(:email => session[:email])
   	  render :action => 'new'   
  end

  def create
    @user = User.new(params[:user])
	  @user.is_registered = 1
    if @user.save 
      
      logger.info "Sending an email to #{@user.email}"
      RegistrationConfirmation.registration_confirmation_to_user(@user).deliver
      RegistrationConfirmation.registration_confirmation_to_host(@user).deliver

      logger.info "Registration successful"
      flash[:notice] = "Registration Successful"
      render :action => "view" 
    else
    	flash[:notice] = @user.errors
     	render :action => "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def show
  	@user = current_user
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
