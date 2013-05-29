require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the UserHelper. For example:
#
# describe UserHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe UsersHelper do

	fixtures :users

	before(:each) do
		activate_authlogic
	end

	it "should tell user is an admin" do
		UserSession.create(users(:two))
		users(:two).should == current_user
		is_admin?.should == true
	end

	it "should tell user is NOT an admin" do
		UserSession.create(users(:one))
		users(:one).should == current_user
		is_admin?.should_not == true
	end

	it "should tell if user is logged in" do
		UserSession.create(users(:one))
		users(:one).should == current_user
		logged_in?.should == true
	end

	it "should tell user is NOT logged in" do
		logged_in?.should_not == true
	end

end
