require 'test_helper'

class MakingAPostTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(name: "Joe",
                         username: "zawarudo",
                         email: "stand@anime.jp",
                         password: "foobar",
                         password_confirmation: "foobar")
  end

  test "should create a post and display it on the user profile page" do
    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
    assert_not flash.empty?
    assert_redirected_to users_path
    get user_profile_path(@user.id)
    assert_select "form"
    post posts_path, params: { post: { author: @user, body: "test" } }
    assert_redirected_to user_profile_path(@user.id)
    assert_not flash.empty?
    assert_equal flash[:notice], "Posted Successfully"
  end
  
end
