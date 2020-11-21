require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.new(name: "Joe",
                     email: "joe@example.com",
                     username: "person01",
                     password: "foobar",
                     password_confirmation: "foobar")
  end

  test "shouldn't sign up with invalid info" do
    @user.name = ""
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: { user: { name: @user.name,
                                                     email: @user.email,
                                                     username: @user.username,
                                                     password: @user.password,
                                                     password_confirmation: @user.password_confirmation } }
      end
  end

  test "users sholuld be created with valid sign up information" do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: { name: @user.name,
                                                     email: @user.email,
                                                     username: @user.username,
                                                     password: @user.password,
                                                     password_confirmation: @user.password_confirmation } }
    end
    assert_redirected_to users_path
  end

  test "creates a profile for the user and send a welcome email upon sign-up" do
    get new_user_registration_path
    assert_difference 'Profile.count', 1 do
      post user_registration_path, params: { user: { name: @user.name,
                                                     email: @user.email,
                                                     username: @user.username,
                                                     password: @user.password,
                                                     password_confirmation: @user.password_confirmation } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
  end

end
