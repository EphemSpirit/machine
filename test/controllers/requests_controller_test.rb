require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(name: "Dio",
                        username: "zawarudo",
                        email: "tarot@readme.com",
                        password: "password",
                        password_confirmation: "password")
  end

  test "creating a friend request requires a logged in user" do
    assert_no_difference 'Request.count' do
      post user_requests_path(@user.id)
    end
  end
end
