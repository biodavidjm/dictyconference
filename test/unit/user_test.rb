require_relative '../test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  #test "the truth" do
    #assert true
  #end

  fixtures :users

  def test_user
  	one_user = User.new :email => books(:one).email,
  						:first_name => books(:one).first_name,
  						:last_name => books(:one).last_name

  	assert one_user.save
  	one_user_copy = User.find(one_user.id)
  	assert_equal one_user.rmail, one_user_copy.email

  	one_user.email = "christucker@movies.com"

  	assert one_user.save
  	assert one_user.destroy
  end
end
