class LikingsController < ApplicationController

  def new
    @liking = current_user.likings.build
  end

  def create
    @liking = current_user.likings.build(liking_params)

    if @liking.save
      flash[:noticed] = "They'll Appreciate That :)"
      redirect_to user_profile_path(current_user.id)
    else
      redirect_to user_profile_path(current_user.id)
    end
  end

  def destroy
    @liking = Liking.find(params[:id])
    @liking.destroy
  end

  private

    def liking_params
      params.require(:liking).permit(:liker_id, :liked_post_id)
    end

end
