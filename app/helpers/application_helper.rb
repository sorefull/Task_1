module ApplicationHelper

  # Likes and dislikes
  def up_votes_of(resource)
    resource.votes.where(vote: :up).count
  end

  def down_votes_of(resource)
    resource.votes.where(vote: :down).count
  end

  def raiting_of(resource)
    up_votes_of(resource) - down_votes_of(resource)
  end

end
