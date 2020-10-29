require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest

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

end
