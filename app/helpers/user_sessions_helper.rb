module UserSessionsHelper
  
  def get_user(the_user)
    User.find_by_email(the_user[:email])
  end
  
  def valid_password?(password)
    ["dicty2010cardiff", "dicty4ever"].include?(password.downcase) if ! password.nil?
  end
    
  def valid_email?(email)
    reg = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
    return (reg.match(email))? true : false
  end
  
end
