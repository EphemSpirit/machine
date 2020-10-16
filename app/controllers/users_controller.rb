class UsersController < ApplicationController
  before_action :not_logged_in, only: [:home]

  def home

  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def not_logged_in
      !user_signed_in?
    end

end
