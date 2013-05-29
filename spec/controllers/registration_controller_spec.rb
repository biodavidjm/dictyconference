require 'spec_helper'

describe RegistrationController do

	fixtures :users
	before(:each) do
		activate_authlogic
	end

	# TODO
	it "should register user" do
		UserSession.create(users(:one))
		users(:one).is_registered.should == false
		put :update, id: users(:one).id, user: {is_registered: true} 
		is_registered?.should == true
	end
end
