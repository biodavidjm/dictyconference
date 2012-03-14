module RegistrationHelper
	# helper_method :redirect_to

	def is_registered?(user=nil)
    	# @user = User.find(:all, :conditions =>['(id = :user_id)', {:user_id => user.id} ])
      logger.info 'User is registered'
      return user.is_registered
  end
end
