require "minitest_helper"

class User2sHelperTest < MiniTest::Rails::Helper
  before do
    @helper= User2sHelper.new
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
