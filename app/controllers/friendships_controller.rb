class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = Friendship.where("friender_id = ? OR friendee_id = ?", current_user.id, current_user.id)
  end

  def new
    @friendship = current_user.friendships.build
  end

  def create
    @friendship = current_user.friendships.build(friendship_params)

    if @friendship.save
      @req = Request.where("sender_id = ? AND receiver_id = ?", @friendship.friender_id, @friendship.friendee_id)
      @req.destroy(@req.ids.first)
      redirect_to user_path(current_user)
      flash[:notice] = "Friend Accepted!"
    else
      redirect_to 'requests#index'
      flash[:notice] = "Soemthing Went Wrong :("
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])

    @friendship.destroy
    redirect_to user_path(current_user)
    flash[:notice] = "Friend Removed"
  end

  private

    def friendship_params
      params.require(:friendship).permit(:friender_id, :friendee_id)
    end

end
