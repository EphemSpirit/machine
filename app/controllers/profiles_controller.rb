class ProfilesController < ApplicationController
  before_action :find_profile, only: [:show, :edit, :destroy]

  def new
    @profile = current_user.profile.build
  end

  def create
    @profile = current_user.profile.build(profile_params)

    if @profile.save
      redirect_to root_url
      flash[:notice] = "Signed Up Siccessfully!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @profile.destroy
    flash[:notice] = "Account Deactivated"
    redirect_to root_url
  end

  private

    def profile_params
      params.require(:profile).permit(:user_id)
    end

    def find_profile
      @profile = current_user.profile
    end

end
