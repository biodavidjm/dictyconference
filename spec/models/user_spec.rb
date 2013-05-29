require 'spec_helper'

describe User do

	before(:each) do
		@attr = { :first_name => "John", :last_name => "Doe", :email => "JohnDoe@superman.com" }
	end

	it "should require a name" do
		no_name_user = User.new(@attr.merge(:first_name => "", :last_name => ""))
		no_name_user.valid?should_not == true
	end

	it "should require an email address" do
		no_email_user = User.new(@attr.merge(:email => ""))
		no_email_user.valid?.should_not == true
	end

	it "should not be an admin be default" do
		not_admin_user = User.new(@attr)
		not_admin_user[:admin].should_not == true
	end

	it "can be made admin" do 
		admin_user = User.new(@attr.merge(:is_admin => true))
		admin_user[:is_admin].should == true
	end

	it "should have a valid email" do
		invalid_email_user = User.new(@attr.merge(:email => "JaneDoe"))
		invalid_email_user.valid?.should_not == true
	end

	it "should return space separated name from first_name & last_name" do
		user_name = User.new(@attr)
		user_name.name.should == 'John Doe'
	end

	it "should require only 3 sttributes to create user" do
		user = User.new(@attr.merge(:address => "", :city => "", :country => ""))	
	end
end
