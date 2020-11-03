module FriendshipsHelper

  def is_friendee?(friendship, user)
    friendship.friendee == user
  end

  def is_friender?(friendship, user)
    friendship.friender.name == user.name
  end

end
