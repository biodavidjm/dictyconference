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
		#assert_redirected_to :home
	end

	it "should show user" do
		UserSession.create(users(:one))
		get :show
		assert_response :success
	end

	it "should get edit" do
		UserSession.create(users(:one))
		get :edit, :id => users(:one).id
		assert_response :success
	end

	it "should update user" do
		UserSession.create(users(:one))
		put :update, :id => users(:one).id, :user => { }
		#assert_redirected_to :home
	end
end
