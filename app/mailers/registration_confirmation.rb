class RegistrationConfirmation < ActionMailer::Base
	default :from => "Dicty13 Registration Bot <no-reply@northwestern.edu>"
	default :to => "yogesh.pandit@northwestern.edu"

	def registration_confirmation_to_user (user)
		@user = user
		mail(
			:to => user.email,
			:subject => "Dicty13 Registration Confirmation",
			:content_type => "text/plain"
		)
	end

	def registration_confirmation_to_host (user)
		@user = user
		mail(
			#:to => ["abc@xyz.com", "pqr@uvw.net"],
			:subject => "New Dicty13 Registration",
			:content_type => "text/plain"
		)
	end

	def update_confirmation_to_host (user)
		@user = user
		mail(
			:subject => "Updated Dicty13 Registration",
			:content_type => "text/plain"
		)
	end

	def update_confirmation_to_user (user)
		@user = user
		mail(
			:to => user.email,
			:subject => "Updated Dicty13 Registration",
			:content_type => "text/plain"
		)
	end

	def abstract_confirmation_to_user (abstract)
		@abstract = abstract
		@user = User.find(@abstract.user_id)
		mail(
			:to => @user.email,
			:subject => "Abstract Submission Confirmation for Dicty13",
			:content_type => "text/plain"
		)
	end

end
