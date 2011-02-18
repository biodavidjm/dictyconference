class Abstract < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title,  :presenter, :abstract, :agreement, :abstract_type, :authors, :address

end
