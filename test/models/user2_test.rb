require "minitest_helper"

class User2Test < MiniTest::Rails::Model
  before do
    @user2 = User2.new
  end

  it "must be valid" do
    @user2.valid?.must_equal true
  end

  it "must be a real test" do
    flunk "Need real tests"
  end

  # describe "when doing its thing" do
  #   it "must be interesting" do
  #     @user2.blow_minds!
  #     @user2.interesting?.must_equal true
  #   end
  # end
end