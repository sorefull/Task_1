module UsersHelper
  def can_subscribe?(user)
    !(current_user&.feed.include? user.id)
  end
end
