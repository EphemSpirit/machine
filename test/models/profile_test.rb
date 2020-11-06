require 'test_helper'

class ProfileTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Joe",
                     username: "zawarudo",
                     email: "stand@anime.jp",
                     password: "foobar",
                     password_confirmation: "foobar")
  end

  test "profile is created upon User creation" do
    assert_not @user.profile
    assert_difference 'Profile.count', 1 do
      @user.save!
    end
  end

  test "profile bio should be less than 250 characters" do
    @user.save
    @user.profile.bio = "This is a test"
    assert @user.profile.valid?
  end

  test "profile bio should not be more than 250 characters" do
    @user.save
    @user.profile.bio = "a" * 251
    assert_not @user.profile.valid?
  end

end
