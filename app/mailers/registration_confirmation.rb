class RegistrationConfirmation < ActionMailer::Base
  default :from => "Dicty12 Registration Bot <no-reply@northwestern.edu>"
  
  def registration_confirmation_to_user (user)
    @user = user
    mail(
      :to => user.email, 
      :subject => "Dicty12 Registration Confirmation",
      :content_type => "text/plain"
      )
  end
  
  def registration_confirmation_to_host (user)
      @user = user
      mail(
        :to => ["abc@xyz.com", "pqr@uvw.net"], 
        :subject => "New Dicty12 Registration",
        :content_type => "text/plain"
        )
    end

end
