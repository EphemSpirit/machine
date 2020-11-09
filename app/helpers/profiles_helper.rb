module ProfilesHelper

  def profile_owner?(profile)
    profile.owner == current_user
  end
  
end
