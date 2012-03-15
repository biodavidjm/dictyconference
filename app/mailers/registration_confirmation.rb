class RegistrationConfirmation < ActionMailer::Base
  default from: "dictybase@northwestern.edu"
  
  def registration_confirmation_to_user (user)
    @user = user
    mail(:to => user.email, 
      :from => "dictyBase <dictybase@northwestern.edu>"
    	:subject => "Dicty12 Registration Confirmation",
    	:body => {:user => user},
    	sent_on => Time.now
    	)
  end

end
