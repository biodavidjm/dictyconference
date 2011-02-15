class UsersController < ApplicationController

  skip_before_filter :login_required, :only => [:new,:create]

  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
      format.csv {
        buffer = FasterCSV.generate do |csv|
          fields_user = [
            :id,
            :email,
            :title,
            :first_name,
            :last_name,
            :gender,
            :affiliation,
            :address,
            :country, 
            :business_phone,
            :mobile_phone,
            :fax,
          ]
          fields_registration = [
            :is_registered
          ]
          all_fields = fields_user.map{|field| field.to_s}.concat( fields_registration.map{|field| field.to_s})
          csv << all_fields
          for user in @users
            registration = Registration.find(:first, :conditions =>['(conference_id = :conference_id and user_id = :user_id)',
              {:conference_id => current_conference.id, :user_id => user.id} ])
            all_data = fields_user.map{|field| value = user.send(field)}
            
            is_registered = registration ? 'Y' : 'N';
            all_data.push( is_registered )
            csv << all_data
          end
        end
        send_data( buffer, :type => 'text/csv; charset=iso-8859-1; header=present', :filename => 'users.csv')

      }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    email = params[:user_session][:email] if ! params[:user_session].nil?
    email ||= params[:email] 
    password = params[:user_session][:password] if ! params[:user_session].nil?
    @user = User.new( :email=>email )

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
     respond_to do |format|
      if @user.save 
          logger.info "Successfully created profile."
          flash[:notice] = "Successfully created profile."
          format.html { redirect_to(new_user_registration_path(@user.id)) }
          format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
          flash[:notice] = @user.errors
          format.html { render :action => "new" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    @user.attributes = params[:user]
    
    respond_to do |format|
      if @user.save
        flash[:notice] = "Successfully updated profile."
        logger.info "Successfully updated profile."
        format.html { redirect_to root_url }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        logger.info "Unable to update profile."
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
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
