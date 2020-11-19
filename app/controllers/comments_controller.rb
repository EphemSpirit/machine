class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = current_user.comments.build
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @post = Post.find(params[:comment][:commented_post_id])

    if @comment.save
      redirect_to user_profile_path(current_user.id)
      flash[:notice] = "Comment Posted"
    else
      render :new
      flash[:notice] = "something's fishy, try again!"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:commenter_id, :commented_post_id, :body)
    end

end
