require "minitest_helper"

class User2ControllerTest < MiniTest::Rails::Controller
  setup do
    @user2 = user2s(:one)
  end

  it "must get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user2s)
  end

  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create user2" do
    assert_difference('User2.count') do
      post :create, user2: @user2.attributes
    end

    assert_redirected_to user2_path(assigns(:user2))
  end

  it "must show user2" do
    get :show, id: @user2.to_param
    assert_response :success
  end

  it "must get edit" do
    get :edit, id: @user2.to_param
    assert_response :success
  end

  it "must update user2" do
    put :update, id: @user2.to_param, user2: @user2.attributes
    assert_redirected_to user2_path(assigns(:user2))
  end

  it "must destroy user2" do
    assert_difference('User2.count', -1) do
      delete :destroy, id: @user2.to_param
    end

    assert_redirected_to user2s_path
  end
end
