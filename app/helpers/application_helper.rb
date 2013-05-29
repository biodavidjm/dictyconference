# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def format_date(the_date)
		the_date.nil? ? '' : the_date.strftime("%m/%d/%Y") #:justdate
	end

	def abstract_submission_open?
		DateTime.parse(Dicty11::Application.config.abstract_submission_deadline) >= DateTime.now ? true: false
	end

	def registration_open?
		DateTime.parse(Dicty11::Application.config.registration_deadline) >= DateTime.now ? true: false
	end

end
