require 'test_helper'

class UpdatingProfileInfoTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(name: "Joe",
                         username: "zawarudo",
                         email: "stand@anime.jp",
                         password: "foobar",
                         password_confirmation: "foobar")
  end

  test "it updates profile info" do
    assert @user.profile
    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
    assert_not flash.empty?
    assert_redirected_to users_path
    get edit_user_profile_path(@user.id)
    put user_profile_path(@user.id), params: { profile: { bio: "test" } }
    assert_redirected_to root_url
    assert_not flash.empty?
    assert_equal flash[:notice], "Profile Info Updated!"
  end

end
