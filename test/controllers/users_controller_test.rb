require "minitest_helper"

class UsersControllerTest < MiniTest::Rails::Controller
  fixtures :users

  setup do
    @user = users(:joe)
  end

  def test_index
    get :index
    assert_response :success
    assert assigns(:users)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('User.count') do
      post :create, user: @user.attributes
    end

    assert_redirected_to user_path(assigns(:user))
  end

  def test_show
    get :show, id: @user.to_param
    assert_response :success
  end

  def test_edit
    get :edit, id: @user.to_param
    assert_response :success
  end

  def test_update
    put :update, id: @user.to_param, user: @user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  def test_destroy
    assert_difference('User.count', -1) do
      delete :destroy, id: @user.to_param
    end

    assert_redirected_to users_path
  end
end
