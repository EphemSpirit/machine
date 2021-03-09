class ProfilesController < ApplicationController
  before_action :find_profile, only: [:show, :edit, :update, :destroy]

  def new
    @profile = current_user.profile.build
  end

  def create
    @profile = current_user.profile.build(profile_params)
    @profile.image.attach(params[:profile][:profile_pic])

    if @profile.save
      redirect_to root_url
      flash[:notice] = "Signed Up Siccessfully!"
    else
      render :new
    end
  end

  def show
    @post = Post.new
    @activities = PublicActivity::Activity.order("created_at DESC").where(owner_id: current_user, owner_type: "User").limit(15)
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = "Profile Info Updated!"
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    @profile.destroy
    flash[:notice] = "Account Deactivated"
    redirect_to root_url
  end

  private

    def profile_params
      params.require(:profile).permit(:user_id, :bio, :birthday, :profile_pic)
    end

    def find_profile
      @profile = current_user.profile
    end

end
