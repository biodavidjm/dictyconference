
require 'open-uri'

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
		if logged_in? and is_registered?
			@user = current_user

			amount = @user.payment_due.gsub("$", "")
			currency_code = "USD"
			timestamp = Time.now.utc.to_i
			x_fp_sequence = Random.rand(1000..100000) + 12345 	
			hmac_data = X_LOGIN + "^" + x_fp_sequence.to_s + "^" + timestamp.to_s + "^" + amount.to_s + "^" + currency_code

			x_fp_hash = OpenSSL::HMAC.hexdigest('md5', TRANSACTION_KEY, hmac_data)

			data = {x_login: X_LOGIN, x_currency_code: currency_code, x_fp_timestamp: timestamp, x_amount: amount, x_fp_sequence: x_fp_sequence, x_fp_hash: x_fp_hash, x_show_form: 'PAYMENT_FORM'}

			url = URI.parse(FIRSTDATA_URL)
			req = Net::HTTP::Post.new(url.path)
			req.form_data = data
			con = Net::HTTP.new(url.host, url.port)
			con.use_ssl = true
			res = con.request(req)

			if res.code == '302'
				# logger.info "Redirecting to - #{res['Location']}"
				#redirect_to res['Location']

				# Parsing cookie check URL
				doc = Nokogiri::HTML(open(res['Location']))
				links = doc.css('a')
				hrefs = links.map { |link| link.attribute('href').to_s}.uniq.sort.delete_if { |href| href.empty?}
				hrefs.each {|href|
					# Matching pattern to check for payment form URL
					if href.match(/^\/payment\/retry_cookies?/)
						logger.info "#{href}"
						payment_form_url = FIRSTDATA_URL.gsub("/payment", "") + href
						# Redirecting to the payment form URL
						redirect_to payment_form_url
					end
				}
				#logger.info "#{hrefs}"

				#url2 = URI.parse(res['Location'])
				#req2 = Net::HTTP::Get.new(url2.path)
				#con2 = Net::HTTP.new(url2.host, url2.port)
				#con2.use_ssl = true
				#res2 = con2.request(req2)

				#logger.info "#{res2.code}"
				#logger.info "#{res2.body}"
				#redirect_to res2['Location']
			else 
				logger.info "Rendering default template"
			end

		end
	end

end
