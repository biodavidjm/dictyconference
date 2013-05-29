require 'spec_helper'

describe AbstractsController do

	fixtures :abstracts

	it "should create an abstract" do
		assert_difference 'Abstract.count' do
			post :create, abstract: {title: "Abstract 2 for Dicty Conference", authors: "Sergio Ramos, Frank Lampard", abstract: "How are you doing?", address: "Warsaw, Poland", agreement: true, presenter: "Frank Lampard", abstract_type: "Poster" }
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
