require 'test_helper'

class RequestTest < ActiveSupport::TestCase

  def setup
    @user = User.create(name: "Dio",
                        username: "zawarudo",
                        email: "tarot@readme.com",
                        password: "password",
                        password_confirmation: "password")
    @friendo = User.create(name: "Dio",
                        username: "zawarudo",
                        email: "tarot@readme.com",
                        password: "password",
                        password_confirmation: "password")
  end

  test "doesn't save a request without a sender" do
    req = @user.requests.build(receiver: @friendo)
    assert_not req.valid?
  end

  test "doesn't save a request without a receiver" do
    req = @user.requests.build(sender: @user)
    assert_not req.valid?
  end

  test "valid with sender and receiver" do
    req = @user.requests.build(sender: @user, receiver: @friendo)
    assert req.valid?
  end

  test "persists valid relationships to datatbase" do
    req = @user.requests.build(sender: @user, receiver: @friendo)
    assert_difference 'Request.count', 1 do
      req.save
    end
    #make sure the request is there
    assert Request.where(sender: @user)
  end

  test "doesn't create duplicate requests" do
    req = @user.requests.build(sender: @user, receiver: @friendo)
    req.save
    assert_no_difference 'Request.count' do
      new_req = @user.requests.build(sender: @user, receiver: @friendo)
      new_req.save
    end
  end

end
