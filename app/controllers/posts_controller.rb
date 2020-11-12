class PostsController < ApplicationController

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = "Posted Successfully"
      redirect_to user_profile_path(current_user.id)
    else
      flash[:notice] = "Something went wrong: #{@post.errors.full_messages}"
      redirect_to user_profile_path(current_user)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post deleted"
    redirect_to user_profile_path(current_user.id)
  end

  private

    def post_params
      params.require(:post).permit(:author_id, :body, :post_img)
    end

end
