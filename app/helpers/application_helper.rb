# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def format_date(the_date)
    the_date.nil? ? '' : the_date.strftime("%m/%d/%Y") #:justdate
  end

  def can_edit?(record=nil)
    record ||= @abstract || @user
    raise ArgumentError, "No record specified" unless record
    return true if is_admin?
    return true if logged_in? && (current_user.id == record.user_id) && abstart_submission_open?
  end
  
  def is_admin?
    logger.info 'User is an admin'
    return true if logged_in? && current_user.is_admin
  end
  
  def logged_in?
    ! current_user.blank?
  end
  
  def is_registered? #(user=nil)
    logger.info 'User is registered'
    return true if logged_in? && current_user.is_registered
  end

  def abstract_submission_open?
    Time.parse(Dicty11::Application.config.abstract_submission_deadline) >= Date.today ? true: false
  end

  def registration_open?
    Time.parse(Dicty11::Application.config.registration_deadline) >= Date.today ? true: false 
  end

end
