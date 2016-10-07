module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy
  end

  def voted?(resource)
    return votes.where(votable_id: resource.id, votable_type: resource.class.to_s).first.present?
  end

  def votes_this!(resource, vote) # vote: [:up, :down, :unvote], resource: [:post]
    case vote
    when 'unvote'
      if voted? resource
        votes.where(votable_id: resource.id, votable_type: resource.class.to_s).first.destroy
        save
      else
        false
      end
    when 'up', 'down'
      unless voted? resource
        self.votes.build(votable_id: resource.id, votable_type: resource.class.to_s, vote: vote)
        save
      else
        false
      end
    else
      false
    end
  end
end
