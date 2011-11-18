require "test_helper"

class UserTest < MiniTest::Rails::Model
  it "#name returns first and last name" do
    user = User.new :first_name => "Joe", :last_name => "Doe"
    user.name.must_equal "Joe Doe"
  end
end
