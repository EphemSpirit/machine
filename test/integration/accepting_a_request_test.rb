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

  # test "updates columns when a request is accepted" do
  #   post user_requests_path(@user.id, request: { sender_id: @user.id, receiver_id: @friendo.id })
  #   assert_equal Request.where(accepted: true).size, 0
  #   assert_difference 'Request.where(accepted: true).size', 1 do
  #     post user_friendships_path(@user.id, friendship: { friender_id: @user.id, friendee_id: @friendo.id })
  #   end
  # end

end
