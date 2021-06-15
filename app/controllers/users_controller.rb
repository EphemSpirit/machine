class UsersController < ApplicationController
  before_action :be_not_logged_in, only: [:home]
  before_action :authenticate_user!, except: [:home]
  after_action :redirect_to_profile, only: [:create]

  #extract this to a static pages controller at some point
  def home

  end

  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    @results = User.where("name LIKE ?", "%#{params[:search][:search_name]}%")
  end

  private

    def be_not_logged_in
      if user_signed_in?
        redirect_to user_path(current_user)
      end
    end

    def redirect_to_profile
      @user = User.find(params[:id])
      redirect_to edit_user_profile_path(@user.id)
    end

end
