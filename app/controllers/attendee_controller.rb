class AttendeeController < ApplicationController
  
	def new
		@attendee = Attendee.new
	end

  	def register
  		@attendee = Attendee.new(params[:attendee])
  		#has_valid_email = valid_email?(params[:attendee][:email])

    	@attendee.save do |result|
      		if result
        		flash[:notice] = "Registration information saved !!!"
        		logger.info "Successfully registered user #{params[:attendee][:email]}."
        		
      		elsif ! has_valid_email
         		@user_session.destroy
         		flash[:notice] = "Please enter a proper email and password."
         		render :action => :register
      		
      		
       		end
    	end
  	end

end
