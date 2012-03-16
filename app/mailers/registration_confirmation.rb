class RegistrationConfirmation < ActionMailer::Base
  default from: "dictybase@northwestern.edu"
  
  def registration_confirmation_to_user (user)
    @user = user
        mail(:to => user.email, 
          :from => "dictybase@northwestern.edu",
          :subject => "Dicty12 Registration Confirmation",
          :body => {:user => user}
          )
    # to  user.email
    #     from  "dictyBase <dictybase@northwestern.edu>"
    #     subject "Dicty12 Registration Confirmation"
    #     sent_on Time.now
    #     body  :user => user
  end
  
  # def registration_confirmation_to_host (user)
  #     @user = user
  #     mail(:to => "", 
  #       :from => "dictyBase <dictybase@northwestern.edu>",
  #       :subject => "New Dicty12 Registration",
  #       :body => {:user => user},
  #       sent_on => Time.now
  #       )
  #   end

end
