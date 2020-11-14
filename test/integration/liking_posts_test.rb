require 'test_helper'

class LikingPostsTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(name: "Joe",
                        username: "whatamidoinghere",
                        email: "joejoe@email.com",
                        password: "foobar",
                        password_confirmation: "foobar")
    @post = Post.create(author: @user, body: "test post")
  end

  test "users can like posts" do
    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
    assert_difference 'Liking.count', 1 do
      post post_likings_path(@post.id), params: { liking: { liker_id: @user.id, liked_post_id: @post.id } }
    end
  end

  test "user must be signed in to like something" do
    assert_no_difference 'Liking.count' do
      post post_likings_path(@post.id), params: { liking: { liker_id: @user.id, liked_post_id: @post.id } }
    end
  end

  test "duplicate likes not allowed" do
    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
    assert_redirected_to users_path
    get user_profile_path(@user.id)
    post post_likings_path(@post.id), params: { liking: { liker_id: @user.id, liked_post_id: @post.id } }
    assert_no_difference 'Liking.count' do
      post post_likings_path(@post.id), params: { liking: { liker_id: @user.id, liked_post_id: @post.id } }
    end
  end

end
