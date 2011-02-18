# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def format_date(the_date)
    the_date.nil? ? '' : the_date.strftime("%m/%d/%Y") #:justdate
  end

  def can_edit?(record=nil)
    record ||= @abstract || @user
    raise ArgumentError, "No record specified" unless record
    return true if is_admin?
    return true if logged_in? && (current_user.id == record.user_id)
  end
  
  def is_admin?
    return true if logged_in? && current_user.is_admin
  end
  
  def logged_in?
    ! current_user.blank?
  end
  
  def abstart_submission_open?
    Time.parse(Dicty11::Application.config.abstract_submission_deadline) >= Date.today ? true: false
  end

end
