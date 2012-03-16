class RegistrationConfirmation < ActionMailer::Base
  default from: "dictybase@northwestern.edu"
  
  def registration_confirmation_to_user (user)
    @user = user
        mail(
          :to => user.email, 
          :from => "Dicty12 Registration Bot <dicty@northwestern.edu>",
          :subject => "Dicty12 Registration Confirmation",
          :content_type => "text/plain"
          )
  end
  
  def registration_confirmation_to_host (user)
      @user = user
      mail(
        :to => ["Yogesh Pandit <yogesh.pandit@northwestern.edu>", "Petra Fey <pfey@northwestern.edu>"], 
        :from => "Dicty12 Registration Bot <dicty@northwestern.edu>",
        :subject => "New Dicty12 Registration",
        :content_type => "text/plain"
        )
    end

end
