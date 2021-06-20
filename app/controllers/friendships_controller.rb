class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @friendships = Friendship.where(friender_id: @user.id).or(Friendship.where(friendee_id: @user.id))
  end

  def new
    @friendship = current_user.friendships.build
  end

  def create
    @friendship = current_user.friendships.build(friendship_params)

    if already_friends?(@friendship)
      redirect_to root_url
      flash[:notice] = "You're Already Friends With This Person"
    elsif @friendship.save
      @req = Request.where("sender_id = ? AND receiver_id = ?", @friendship.friender_id, @friendship.friendee_id)
      @req.update(accepted: true)
      redirect_to user_path(current_user)
      flash[:notice] = "Friend Accepted!"
    else
      redirect_to 'requests#index'
      flash[:notice] = "Something Went Wrong :("
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

    def already_friends?(friendship)
      Friendship.any?{ |x| x.friender == friendship.friender && x.friendee == friendship.friendee } ||
      Friendship.any?{ |x| x.friender == friendship.friendee && x.friendee == friendship.friender }
    end

end
