module Followable
  extend ActiveSupport::Concern

  included do
    has_many :active_relationships, class_name:  "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy

    has_many :passive_relationships, class_name:  "Relationship",
                                     foreign_key: "followed_id",
                                     dependent:   :destroy

    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
  end

  # Follows a user.
  def follow(other_user)
    if self.following? other_user
      false
    elsif self == other_user
      false
    else
      active_relationships.create(followed_id: other_user.id)
      true
    end
  end

  # Unfollows a user.
  def unfollow(other_user)
    if !(self.following? other_user)
      false
    elsif self == other_user
      false
    else
      active_relationships.find_by(followed_id: other_user.id).destroy
      true
    end
  end

  def set_this_user_to(user, new_relation) # new_relation: [:follow, :unfollow]
    case new_relation
    when 'follow'
      self.follow user
    when 'unfollow'
      self.unfollow user
    else
      false
    end
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
end
