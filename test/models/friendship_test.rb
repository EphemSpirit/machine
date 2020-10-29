require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase


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

  test "should require friender_id" do
    friendship = @user.friendships.build(friendee_id: @friendo.id)
    assert_not friendship.valid?
  end

  test "should require a friendee_id" do
    friendship = @user.friendships.build(friender_id: @user.id)
    assert_not friendship.valid?
  end

  test "saves a valid friendship" do
    friendship = @user.friendships.build(friender_id: @user.id, friendee_id: @friendo.id)
    assert_difference 'Friendship.count', 1 do
      friendship.save
    end
  end


end
