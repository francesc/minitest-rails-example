class UsersIntegrationTest < MiniTest::Rails::IntegrationTest
  fixtures :users

  it "can sign in" do
    joe  = sign_in users(:joe)
    jane = sign_in users(:jane)

    joe.flash[:notice].must_equal "Welcome Joe!"
    jane.flash[:notice].must_equal "Welcome Jane!"
  end

private
  def sign_in(user)
    open_session do |sess|
      sess.post "/sessions", username: user.username, password: user.password
      sess.follow_redirect!
      sess.path.must_equal "/"
    end
  end
end
