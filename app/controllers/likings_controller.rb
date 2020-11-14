class LikingsController < ApplicationController
  before_action :authenticate_user!
  before_action :not_previously_liked, only: [:new, :create]

  def new
    @liking = current_user.likings.build
  end

  def create
    @liking = current_user.likings.build(liking_params)
    @post = Post.find(params[:liking][:liked_post_id])

    if Liking.where(liker_id: current_user.id, liked_post_id: @post.id).any?
      redirect_to user_profile_path(current_user.id)
    elsif @liking.save
      redirect_to user_profile_path(current_user.id)
      flash[:noticed] = "They'll Appreciate That :)"
    else
      redirect_to user_profile_path(current_user.id)
    end
  end

  def destroy
    @liking = Liking.find(params[:id])
    @liking.destroy
    redirect_to user_profile_path(current_user.id)
  end

  private

    def liking_params
      params.require(:liking).permit(:liker_id, :liked_post_id)
    end

    def not_previously_liked
      Liking.where(liker_id: current_user.id, liked_post_id: params[:liked_post_id]).any?
    end

end
