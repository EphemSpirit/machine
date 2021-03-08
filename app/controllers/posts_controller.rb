class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_is_author?, only: [:destroy]

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

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post deleted"
    redirect_to user_path(current_user.id)
  end

  private

    def post_params
      params.require(:post).permit(:author_id, :body, :post_img)
    end

    def user_is_author?
      @post = Post.find(params[:id])
      @post.author == current_user
    end

end
