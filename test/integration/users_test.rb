require "test_helper"

class UsersTest < MiniTest::Rails::Integration
  fixtures :users

  it "can view list of users" do
    visit "/"
    assert page.has_content?("Joe")
    assert page.has_content?("Jane")
  end

  it "can add new user" do
    visit "/users/new"
    fill_in "First name", with: "James"
    fill_in "Last name",  with: "Doe"
    click_button "Create User"

    page.has_content?("User was successfully created.").must_equal true
    user = User.last
    user.first_name.must_equal "James"
    user.last_name.must_equal "Doe"
  end

  it "can edit user" do
    visit "/"

    user = users(:joe)
    within "#user-#{user.id}" do
      click_link "Edit"
    end

    fill_in "First name", with: "New Joe"
    fill_in "Last name",  with: "New Doe"
    click_button "Update User"

    page.has_content?("User was successfully updated.").must_equal true
    user.reload
    user.first_name.must_equal "New Joe"
    user.last_name.must_equal "New Doe"
  end

  it "can remove user" do
    visit "/"

    count = User.count
    user = users(:joe)
    within "#user-#{user.id}" do
      click_link "Destroy"
    end

    User.count.must_equal count - 1
  end
end
