module FriendshipsHelper

  def is_friendee?(friendship, user)
    friendship.friendee == user
  end

end
