class RequestsController < ApplicationController
  before_action :find_request, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!

  def index
    @requests = Request.where("receiver_id = ? AND accepted IS NULL", current_user.id)
  end

  def new
    @request = current_user.requests.build
  end

  def create
    @request = current_user.requests.build(request_params)

    if Request.all.any?{ |x| x.receiver_id == @request.receiver_id } #stop a user from requesting a friendship twice
      redirect_to users_path
      flash[:notice] = "Stop Badgering This Poor Soul! :/"
    elsif @request.save
      redirect_to users_path
      flash[:notice] = "Friend Request Delievered"
    else
      redirect_to users_path
      flash[:notice] = "Something Went Wrong :("
    end
  end

  def show
  end

  def edit
  end

  def update
    #need to move the updated request OUT of the current_user's requests
    @request.update_columns(accepted: false)
    redirect_to user_path(current_user)
    flash[:notice] = "Friendship Denied"
  end

  def destroy
    @request.destroy
  end

  private

    def find_request
      @request = Request.find(params[:id])
    end

    def request_params
      params.require(:request).permit(:sender_id, :receiver_id)
    end

end
