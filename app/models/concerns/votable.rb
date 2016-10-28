module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def voted?(user)
    return votes.where(user_id: user.id).first.present?
  end

  def vote(user, vote) # vote: [:up, :down, :unvote], resource: [:post]
    case vote
    when 'unvote'
      if voted? user
        votes.where(user_id: user.id).first.destroy
        save
      else
        false
      end
    when 'up', 'down'
      unless voted? user
        votes.build(user_id: user.id, vote: vote)
        save
      else
        false
      end
    else
      false
    end
  end


  def up_votes
    votes.where(vote: :up).count
  end

  def down_votes
    votes.where(vote: :down).count
  end

  def raiting
    up_votes - down_votes
  end
end
