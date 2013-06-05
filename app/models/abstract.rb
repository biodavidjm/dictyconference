class Abstract < ActiveRecord::Base

	belongs_to :user

	validates_presence_of :title,  :presenter, :abstract, :agreement, :abstract_type, :authors, :address
	validates_inclusion_of :abstract_type, :in => ["Talk", "Poster"], :allow_nil => false

end
