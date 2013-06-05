require 'spec_helper'

describe UsersController do

	fixtures :users
	before(:each) do
		activate_authlogic
	end

	it "should create user" do
		assert_difference 'User.count' do
			post :create, user: { first_name: "Harry", last_name: "Potter", email: "hp@jkr.net" }
		end
	end

	it "should show user" do
		get :show, :id => users(:one).id
		assert_response 302
	end

	it "should get edit" do
		get :edit, :id => users(:one).id
		assert_response :success
	end

	it "should update user" do
		put :update, :id => users(:one).id, :user => { }
	end
end
