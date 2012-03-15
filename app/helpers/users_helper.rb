module UsersHelper
  
  def has_abstract?(user=nil)
    ! abstracts(user).blank?
  end
  
  def abstracts(user=nil)
    return Abstract.find(:all, :conditions =>['(user_id = :user_id)', {:user_id => user.id} ])
  end
end
