require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(name: "user",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should show user to correct user" do
    @user.save
    get user_path(@user)
    assert_response :success
  end

  # test "should not show user to incorrect user" do
  #   @user.save
  #   @user_two = @user.dup
  #   @user_two.name = "user 2"
  #   @user_two.save
  #   assert_not true
  #
  # end
end
