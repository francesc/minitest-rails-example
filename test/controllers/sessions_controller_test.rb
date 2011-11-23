require "test_helper"

describe SessionsController do
  describe "#create" do
    before do
      stub(User).authenticate { user }
      post :create
    end

    context "on success" do
      let(:user) { User.new(:first_name => "Johny") }
      #must { set_the_flash.to("Welcome Johny!") }
      must { redirect_to("/") }
    end

    context "on failure" do
      let(:user) { nil }
      #must { set_the_flash.to("Username and/or password is incorrect") }
      must { render_template(:new) }
    end
  end

  describe "#destroy" do
    it "sets the user_id session key to nil" do
      delete :destroy
      session[:user_id].must_equal nil
      assert_redirected_to "/"
    end
  end
end
