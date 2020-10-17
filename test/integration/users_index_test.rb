require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(name: "Joe",
                         username: "starplatinum",
                         email: "stand@anime.jp",
                         password: "password",
                         password_confirmation: "password")
  end

  test "index page with pagination" do
    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
    assert_redirected_to users_path
    follow_redirect!
    first_page = User.paginate(page: 1)
    first_page.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
    end
  end
end
