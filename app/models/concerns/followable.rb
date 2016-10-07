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

  # Follows an outer_resource.
  def follow(outer_resource)
    if self.following? outer_resource
      false
    elsif self == outer_resource
      false
    else
      active_relationships.create(followed_id: outer_resource.id)
      true
    end
  end

  # Unfollows an outer_resource.
  def unfollow(outer_resource)
    if !(self.following? outer_resource)
      false
    elsif self == outer_resource
      false
    else
      active_relationships.find_by(followed_id: outer_resource.id).destroy
      true
    end
  end

  # Creates a new relation [:follow, :unfollow] with outer_resource.
  def new_relation_with(outer_resource, new_relation) # new_relation: [:follow, :unfollow]
    case new_relation
    when 'follow'
      self.follow outer_resource
    when 'unfollow'
      self.unfollow outer_resource
    else
      false
    end
  end

  # Returns true if self is following the outer_resource.
  def following?(outer_resource)
    following.include?(outer_resource)
  end
end
