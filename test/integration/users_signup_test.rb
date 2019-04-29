require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup doesn't work" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name:  "",
                                     password:              "foo",
                                     password_confirmation: "bar" } }
      end
      assert_template 'users/new'
  end

  test "valid signup works" do
    get signup_path
    assert_difference 'User.count' do
      post signup_path, params: { user: { name:  "New User",
                                     password:              "foobar",
                                     password_confirmation: "foobar" } }
    end
    # assert_redirected_to user_path
    follow_redirect!
    assert_template 'users/show'
  end
end
