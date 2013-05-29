require 'spec_helper'

describe Abstract do

	before(:each) do
		@abs = {:title => "DictyConf Abstract Title", :presenter => "Man of Steel", :abstract => "With Gr8 power comes Gr8 responsibility", :agreement => true, :abstract_type => 'Talk', :authors => "Iron Man, The Hulk", :address => "The WhiteHouse, Washington D.C, US"}
	end

	it "should create a new abstract" do 
		abstract = Abstract.new(@abs)
		abstract.valid?.should == true
	end

	it "should require all 7 attributes" do
		incomplete_abstract = Abstract.new(@abs.merge(:abstract_type => ""))
		incomplete_abstract.valid?.should_not == true
	end

	it "should NOT have abstract_type other than {Talk|Poster}" do
		no_type_abstract = Abstract.new(@abs.merge(:abstract_type => "Visual"))
		no_type_abstract.valid?.should_not == true
		null_abstract_type = Abstract.new(@abs.merge(:abstract_type => nil))
		null_abstract_type.valid?.should == false
	end
end
