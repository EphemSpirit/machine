require 'test_helper'

class PostACommentTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(name: "John",
                        email: "user@example.net",
                        username: "whatisthis01",
                        password: "foobar",
                        password_confirmation: "foobar")
    @poster = User.create(name: "Bill",
                          email: "billybob@email.com",
                          username: "hickboy02",
                          password: "password",
                          password_confirmation: "password")
    @post = Post.create(author: @poster, body: "test post")
  end

  test "users can post a comment" do
    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
    #build a friendship between the two users
    post user_friendships_path(@user.id), params: { friendship: { friender: @user, friendee: @poster } }
    get user_profile_path(@user.id)
    assert_select "a[href=?]", user_path(@poster.id)
    assert_select "a[href=?]", new_post_comments_path(@post.id)
    get new_post_comments_path(@post.id)
    assert_difference 'Comment.count', 1 do
      post post_comments_path(@post.id), params: { post: { comment: { commenter_id: @user.id, commented_post_id: @post.id, body: "test comment" } } }
    end
    assert_redirected_to user_profile_path(@user.id)
  end
end
