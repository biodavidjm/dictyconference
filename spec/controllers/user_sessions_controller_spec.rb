require 'spec_helper'

describe UserSessionsController do

	fixtures :users

	it "should create user session" do
		post :create, :user_session => { :email => "jane_doe@antartica.org" }
		assert user_session = UserSession.find
		users(:one).should == user_session.user
		users(:two).should_not == user_session.user
	end

	it "should destroy existing session" do
		post :create, :user_session => { :email => "jane_doe@antartica.org" }
		delete :destroy
		assert_nil UserSession.find
		assert_redirected_to :login
	end

	it "should redirect to signup, if user doesn't exist" do 
		post :create, :user_session => { :email => "sergio_ramos@fifa.org" }
		assert_redirected_to new_user_path
	end

end
