module UsersHelper

	def has_abstract?(user=nil)
		!abstracts(user).blank?
	end

	def abstracts(user=nil)
		return Abstract.find(:all, :conditions =>['(user_id = :user_id)', {:user_id => user.id} ])
	end

	def logged_in?
		!current_user.blank?
	end

	def is_admin?
		return true if logged_in? && current_user.is_admin
	end

	def is_registered?
		return true if logged_in? && current_user.is_registered
	end

	def can_edit?(record=nil)
		record ||= @abstract || @user
		raise ArgumentError, "No record specified" unless record
		return true if is_admin?
		return true if logged_in? && (current_user.id == record.user_id) && abstract_submission_open?
	end
end
