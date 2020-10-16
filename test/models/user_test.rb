require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Drew", email: "dhund90@sbcglobal.com", username: "dhund90", password: "password", password_confirmation: "password")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "user should have a name" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "user should have an email" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "user should have a username" do
    @user.username = ""
    assert_not @user.valid?
  end

  test "email should be valid" do
    emails = %w[email@website.com user01@company.jp USER@foo.com PErsON@business.ca]
    emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test "invalid emails shouldn't be accepted" do
    bad_emails = %w[person@ user@website;com thing01@website. user.com]
    bad_emails.each do |bad_email|
      @user.email = bad_email
      assert_not @user.valid?, "#{bad_email.inspect} should be invalid"
    end
  end

  test "username should be greater than 6 characters" do
    @user.username = "short"
    assert_not @user.valid?
  end

  test "username should be less than 20 characters" do
    @user.username = "a" * 21
    assert_not @user.valid?
  end

  test "suername should be unique" do
    clone = @user.dup
    @user.save
    assert_not clone.valid?
  end

end
