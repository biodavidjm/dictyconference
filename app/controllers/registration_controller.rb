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

			amount = @user.payment_due.gsub("$", "")
			currency_mode = "USD"
			timestamp = Time.now
			fp_sequence = Random.rand(1000..100000) + 12345 	
			hmac_data = X_LOGIN + "^" + fp_sequence.to_s + "^" + timestamp.to_s + "^" + amount.to_s + "^" + currency_mode

			hash = Hash[TRANSACTION_KEY, hmac_data.strip!]

			# digest = HMAC::MD5.new(hash.to_s).hexdigest
			x_fp_hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('md5'), TRANSACTION_KEY, hash.to_s)
			session[:x_fp_hash] = x_fp_hash

		end
	end

   # def checkout

		#logger.info "#{session[:x_fp_hash]}"
		#url = URI.parse(FIRSTDATA_URL)
		#req = Net::HTTP::Post.new(url.path)
		#req.form_data = session[:x_fp_hash]
		#con = Net::HTTP.new(url.host, url.port)
		#con.use_ssl = true
		#con.start {|http| http.request(req)}

		##connection = Net::HTTP.new('https://demo.globalgatewaye4.firstdata.com/payment')
		##reponse = connection.post('', @x_fp_hash)
   # end

end
