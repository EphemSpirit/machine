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

  #figure out hwo to write this test

  test "updates columns when a request is accepted" do
    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
    get user_path(@friendo.id)
    post user_requests_path(@user.id, request: { sender_id: @user.id, receiver_id: @friendo.id })
    assert_equal Request.where(accepted: true).size, 0
    assert_difference 'Request.where(accepted: true).size', 1 do
      post user_friendships_path(@user.id, friendship: { friender_id: @user.id, friendee_id: @friendo.id })
    end
  end

  test "duplicate requests not allowed" do
    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
    get user_path(@friendo.id)
    #send the friend request
    post user_requests_path(@user.id, request: { sender_id: @user.id, receiver_id: @friendo.id })
    #I'll friggin do it again
    assert_no_difference 'Request.count' do
      post user_requests_path(@user.id, request: { sender_id: @user.id, receiver_id: @friendo.id })
    end
  end

  test "accepting a request generates a friendship" do
    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
    get user_path(@friendo.id)
    #send a request
    post user_requests_path(@user.id, request: { sender_id: @user.id, receiver_id: @friendo.id })
    #log out as user
    delete destroy_user_session_path
    #log in as friendo
    get new_user_session_path
    post user_session_path, params: { user: { email: @friendo.email, password: @friendo.password } }
    get user_requests_path(@friendo.id)
    assert_difference 'Friendship.count', 1 do
      post user_friendships_path(@friendo.id, friendship: { friender_id: @user, friendee_id: @friendo.id })
    end
  end

end
