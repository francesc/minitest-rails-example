require "test_helper"

class UsersTest < MiniTest::Rails::Integration
  fixtures :users

  it "can view list of users" do
    visit "/"

    assert page.has_content?("Joe")
    assert page.has_content?("Jane")
  end

  it "can view empty list of users" do
    User.delete_all

    visit "/"

    refute page.has_content?("Destroy")
    assert page.has_content?("No users found.")
  end

  it "can add new user" do
    create_user "James", "Doe"

    page.has_content?("User was successfully created.").must_equal true
    user = User.last
    user.first_name.must_equal "James"
    user.last_name.must_equal "Doe"
  end

  it "can't add new user with invalid data" do
    create_user "James", ""

    page.has_content?("Last name can't be blank").must_equal true
  end

  it "can edit user" do
    user = users(:joe)

    update_user user, "New Joe", "New Doe"

    page.has_content?("User was successfully updated.").must_equal true
    user.reload
    user.first_name.must_equal "New Joe"
    user.last_name.must_equal "New Doe"
  end

  it "can't edit user with invalid data" do
    user = users(:joe)

    update_user user, "New Joe", ""

    page.has_content?("Last name can't be blank").must_equal true
  end

  it "can remove user" do
    count = User.count
    user = users(:joe)
 
    visit "/"
    within "#user-#{user.id}" do
      click_link "Destroy"
    end

    User.count.must_equal count - 1
  end

private

  def create_user(first_name, last_name)
    visit "/users/new"
    set_user first_name, last_name
    click_button "Create User"
  end

  def update_user(user, first_name = nil, last_name = nil)
    visit "/"
    within "#user-#{user.id}" do
      click_link "Edit"
    end
    set_user first_name, last_name
    click_button "Update User"
  end

  def set_user(first_name = nil, last_name = nil)
    fill_in "First name", with: first_name if first_name
    fill_in "Last name",  with: last_name if last_name
  end
end
