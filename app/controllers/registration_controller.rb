class RegistrationController < ApplicationController

	include UsersHelper

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

			# Send confirmation emails to the host and the user
			RegistrationConfirmation.registration_confirmation_to_user(@user).deliver
			RegistrationConfirmation.registration_confirmation_to_host(@user).deliver

			logger.info "Registration successful"
			flash[:notice] = "Registration Successful"
			render :action => "confirm"
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
		if logged_in?
			@user = User.find(params[:id])
		else
			redirect_to login_path
		end
	end

	def update
	end

	def view
	end

	def payment
		if logged_in?
			@user = current_user

			logger.info "Processing registration payment"

			amount = @user.payment_due.gsub("$", "")
			timestamp = Time.now.utc.to_i
			x_fp_sequence = Random.rand(1000..100000) + 12345 	
			hmac_data = X_LOGIN + "^" + x_fp_sequence.to_s + "^" + timestamp.to_s + "^" + amount.to_s + "^USD"

			x_fp_hash = OpenSSL::HMAC.hexdigest('md5', TRANSACTION_KEY, hmac_data)

			#data = {x_login: X_LOGIN, x_currency_code: "USD", x_fp_timestamp: timestamp, x_amount: amount, x_fp_sequence: x_fp_sequence, x_fp_hash: x_fp_hash, x_show_form: 'PAYMENT_FORM'}

			#url = URI.parse(FIRSTDATA_URL)
			#req = Net::HTTP::Post.new(url.path)
			#req.form_data = data
			#con = Net::HTTP.new(url.host, url.port)
			#con.use_ssl = true
			#res = con.request(req)

			#if res.code == '302'
				#logger.info "Redirecting to - #{res['Location']}"
				#redirect_to res['Location']
			#else 
				#logger.info "Rendering default template"
			#end

		end
	end

end
