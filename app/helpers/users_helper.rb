module UsersHelper

  def is_friend?(user, possible_friend)
    user.friends.include?(possible_friend) || user.inverse_friends.include?(possible_friend)
  end

end
