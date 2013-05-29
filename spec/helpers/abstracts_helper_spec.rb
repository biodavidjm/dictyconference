require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the RegistrationsHelper. For example:
#
# describe AbstractsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe AbstractsHelper do
	before(:each) do
		DictyConfig.abstracts['begin'] = DateTime.now.to_s
		DictyConfig.abstracts['end'] = (DateTime.now + 10.days).to_s
	end

	it "abstracts submission should be open" do
		abstracts_submission_open?.should == true
	end

	it "abstracts submission should be closed" do
		DictyConfig.abstracts['end'] = DateTime.now.ago(2.hours).to_s
		abstracts_submission_open?.should_not == true
	end
end
