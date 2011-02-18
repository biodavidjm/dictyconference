class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field :email
    c.validate_password_field(false)
  end

  validates_presence_of :email,  :first_name, :last_name

#  has_many :abstracts, :dependent => :delete_all
  before_save :lowercase_email
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
  
end
