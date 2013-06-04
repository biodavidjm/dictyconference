require 'spec_helper'
require 'pp'

describe AbstractsController do

	fixtures :abstracts, :users

	before(:each) do
		activate_authlogic
	end

	it "should create an abstract" do
		UserSession.create(users(:one))
		user_session = UserSession.find
		assert_difference 'Abstract.count' do
			post :create, abstract: {user_id: user_session.user, title: "Abstract 2 for Dicty Conference", authors: "Sergio Ramos, Frank Lampard", abstract: "How are you doing?", address: "Warsaw, Poland", agreement: true, presenter: "Frank Lampard", abstract_type: "Poster" }
		end
	end

	# TODO - 
	it "should not accept abstract if agreement not true" do

	end

	# TODO - 
	it "should render path to show abstract" do

	end

	# TODO - 
	it "should update abstract" do

	end
end
