module UsersHelper

  def is_friend?(user, possible_friend)
    user.friends.include?(possible_friend) || user.inverse_friends.map(&:friender).include?(possible_friend)
  end

  def has_pending?(user)
    Request.where("sender_id = ? OR receiver_id = ? AND accepted = ?", user.id, user.id, nil)
  end

  def all_friends(user)
    user.friends | user.inverse_friends.map(&:friender)
  end

end
