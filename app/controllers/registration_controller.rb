class RegistrationController < ApplicationController
	#current_tab :registration


	def new
		@user = User.new
		email = params[:user_session][:email] if ! params[:user_session].nil?
  #   	email ||= params[:email] 
  #   	password = params[:user_session][:password] if ! params[:user_session].nil?
  #   	@user = User.new(:password=>password, :email=>email )

  #   	respond_to do |format|
  #     		format.html # new.html.erb
  #     		format.xml  { render :xml => @user }
  #   	end
	end

	def index
	end

	def create
		

	end

	def destroy

	end

	def show
	end

	def update

	end
end
