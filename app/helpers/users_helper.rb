module UsersHelper
  
  def has_abstract?(user=nil)
    ! abstracts(user).blank?
  end
  
  def abstracts(user=nil)
    return Abstract.find(:all, :conditions =>['(user_id = :user_id)', {:user_id => user.id} ])
  end

  # def is_registered?(user=nil)
  #   	# @user = User.find(:all, :conditions =>['(id = :user_id)', {:user_id => user.id} ])
  #     logger.info 'User is registered'
  #     return user.is_registered
  # end
end
