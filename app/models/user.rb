class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field :email
    c.validate_password_field(false)
  end

  #if session[:where_from] == 'registration'
  	validates_presence_of :first_name, :last_name, :institute, :address, :city, :zipcode, :country, :phone
  #elsif session[:where_from] == 'abstract'
	#validates_presence_of :first_name, :last_name
  #end 
  validates :email,   
            :presence => true,   
            :uniqueness => true, 
            :format => { 
              :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i 
            }


#  has_many :abstracts, :dependent => :delete_all
  before_save :lowercase_email, :validate_date
  before_validation :set_username
  
  def name
    [first_name, last_name].join(' ')
  end

  private
    
  def lowercase_email
    self.email=self.email.downcase if !self.email.blank?
  end
  
  def set_username
    if self.username.blank?
      self.username = self.email.downcase if !self.email.blank?
    end
  end

  private

  def validate_date
    if self.extra_accommodation
      if !self.check_in.is_a?(Date)
        errors.add(:check_in, 'Must be a valid date') 
      elsif !self.check_out.is_a?(Date)
      errors.add(:check_out, 'must be a valid date')  
      end
    end
  end

  
end
