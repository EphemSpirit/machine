require 'test_helper'

class EditAccountTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(name: "Joe",
                         username: "starplatinum",
                         email: "stand@anime.jp",
                         password: "password",
                         password_confirmation: "password")
  end

  test "incorrect info" do
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
    get edit_user_registration_path
    patch user_registration_path, params: { user: { name: "", email: "wrong@", password: "foo", password_confirmation: "bar" } }
    assert_template 'devise/registrations/edit'
    assert_select 'div#error_explanation'
  end

  test "valid info" do
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
    get edit_user_registration_path
    name = "Dio"
    patch user_registration_path, params: { user: { name: name, email: @user.email, current_password: @user.password } }
    assert_not flash.empty?
    assert_redirected_to users_path
    @user.reload
    assert_equal @user.name, name
  end

end
