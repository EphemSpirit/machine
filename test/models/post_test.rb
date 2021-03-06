require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = User.create(name: "Joe",
                     username: "zawarudo",
                     email: "stand@anime.jp",
                     password: "foobar",
                     password_confirmation: "foobar")
  end


  test "post doesn't save without a body" do
    @post = Post.new(author: @user)
    assert_not @post.valid?
  end

  test "post doesn't save without an author" do
    @post = Post.new(body: "test")
    assert_not @post.valid?
  end

  test "accepts a valid post as valid" do
    @post = Post.new(author: @user, body: "test")
    assert @post.valid?, @post.errors.full_messages
  end

  test "save valid posts" do
    @post = Post.new(author: @user, body: "test")
    assert_difference 'Post.count', 1 do
      @post.save
    end
  end

end
