require 'test_helper'

class UserSignInTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create!(name: "Joe",
                         username: "zawarudo",
                         email: "stand@anime.jp",
                         password: "foobar",
                         password_confirmation: "foobar")
  end

  test "should fail with invalid info" do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: { user: { email: "", password: "" } }
    assert_template 'devise/sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "invalid email" do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: { user: { email: "", password: @user.password } }
    assert_template 'devise/sessions/new'
    assert_not flash.empty?
  end

  test "valid info" do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", destroy_user_session_path, count: 0
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
    assert_redirected_to users_path
    follow_redirect!
    assert_select "a[href=?]", new_user_registration_path, count: 0
    assert_select "a[href=?]", destroy_user_session_path
    assert_select "a[href=?]", users_path
  end
end
