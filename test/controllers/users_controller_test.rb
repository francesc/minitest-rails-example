require "test_helper"

describe UsersController do
  fixtures :users

  before do
    @user = users(:joe)
  end

  describe "#index" do
    before { get :index }
    must { respond_with(:success) } 
    must { assign_to(:users) }
  end

  describe "#new" do
    before { get :new }
    must { render_template(:new) }
  end

  describe "#create" do
    before do
      any_instance_of User, save: success
      post :create
    end

    describe "on success" do
      let(:success) { true }
      must { respond_with(:redirect) }
    end

    describe "on failure" do
      let(:success) { false }
      must { render_template(:new) }
    end
  end

  describe "#show" do
    before { get :show, id: @user.to_param }
    must { render_template(:show) }
  end

  describe "#edit" do
    before { get :edit, id: @user.to_param }
    must { render_template(:edit) }
  end

  describe "#update" do
    before do
      any_instance_of User, save: success
      put :update, id: @user.to_param
    end

    describe "on success" do
      let(:success) { true }
      must { respond_with(:redirect) }
    end

    describe "on failure" do
      let(:success) { false }
      must { render_template(:edit) }
    end
  end

  describe "#destroy" do
    before { delete :destroy, id: @user.to_param }
    must { respond_with(:redirect) }
  end
end
