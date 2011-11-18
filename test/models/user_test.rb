require "test_helper"

class UserTest < MiniTest::Rails::Model
  subject { User.new }

  it { must have_valid(:first_name).when("Good") }
  it { wont have_valid(:first_name).when(nil, "") }

  it { must have_valid(:last_name).when("Good") }
  it { wont have_valid(:last_name).when(nil, "") }

  it "#name returns first and last name" do
    user = User.new :first_name => "Joe", :last_name => "Doe"
    user.name.must_equal "Joe Doe"
  end
end
