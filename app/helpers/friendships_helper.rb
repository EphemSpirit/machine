module FriendshipsHelper

  def is_friendee?(friendship, user)
    friendship.friendee == user
  end

  def is_friender?(friendship, user)
    friendship.friender.name == user.name
  end

  def total_friends(user)
    user.friends.all.size + user.inverse_friends.all.size
  end

  def all_friends(user)
    user.friends + user.inverse_friends
  end

end
