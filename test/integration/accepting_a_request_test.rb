require 'test_helper'

class AcceptingARequestTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(name: "Dio",
                        username: "zawarudo",
                        email: "tarot@readme.com",
                        password: "password",
                        password_confirmation: "password")
    @friendo = User.create(name: "Joe",
                        username: "starplatinum01",
                        email: "cards@readme.com",
                        password: "password",
                        password_confirmation: "password")
  end

  test "updates columns when a request is accepted" do
    post user_requests_path(@user.id, request: { sender: @user, receiver: @friendo })
    assert_equal 0, Request.where(accepted: true).size
    post user_friendships_path(@user.id, friendship: { friender_id: @user.id, friendee_id: @friendo.id })
    assert_equal 1, Request.where(accepted: true).size
  end
end
