require 'test_helper'

class UpdatingProfileInfoTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(name: "Joe",
                         username: "zawarudo",
                         email: "stand@anime.jp",
                         password: "foobar",
                         password_confirmation: "foobar")
  end

  test "it updates profile info" do
    assert @user.profile
    get edit_user_profile_path(@user.id)
    assert_nil @user.profile.bio
    assert_nil @user.profile.birthday
    patch user_profile_path(@user.id), params: { profile: { user_id: @user.id,
                                                            bio: "this is a test",
                                                            birthday: Faker::Date.birthday(min_age: 18, max_age: 50),
                                                            profile_pic: Faker::Fillmurray.image } }
    assert_equal @user.profile.bio, "this is a test"
    assert_not_nil @user.profile.birthday
  end

end
