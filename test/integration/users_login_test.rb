require 'test_helper'
include SessionsHelper

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:nick)
    @other_user = users(:fred)
  end

  test "invalid login doesn't work" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: "", password: ""}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "valid login works" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: @user.name, password: "foobar"}}
    assert_equal @user, current_user
    assert_redirected_to @user
    assert logged_in?
    follow_redirect!
    assert_not flash.empty?
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", logout_path
    get root_path
    assert flash.empty?
  end

  test "valid logout works" do
    get login_path
    post login_path, params: { session: { name: @user.name, password: "foobar"}}
    follow_redirect!
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_not logged_in?
  end

  test "should show user to correct user" do
    get login_path
    post login_path, params: { session: { name: @user.name, password: "foobar"}}
    follow_redirect!
    get user_path(@user)
    assert_response :success
    assert_select "p", {count: 1, text: "Nick"}
  end

  test "does not show users while not logged in" do
    get user_path(@user)
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a",  {count: 1, text: "New user"}
  end

  test "does not show other users while logged in" do
    get login_path
    post login_path, params: { session: { name: @user.name, password: "foobar"}}
    follow_redirect!
    get user_path(@other_user)
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a", {text: "New user"}
    # assert_select "p",  {count: 0, text: "Nick"}
    # # assert_template 'pages/home'
  end
end
