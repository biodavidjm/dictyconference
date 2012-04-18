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

      # Send confirmation emails to user and the host
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
    render :action => 'edit'
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
  	@user = User.find(params[:id])
  	#@user = current_user
	end

	def update
	end

end
