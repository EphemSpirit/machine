class UsersController < ApplicationController
  before_action :be_not_logged_in, only: [:home]

  def home

  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def be_not_logged_in
      if user_signed_in?
        redirect_to user_path(current_user)
      end
    end

end
