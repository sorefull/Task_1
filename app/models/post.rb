# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :body, presence: true, length: { maximum: 140 }

  # votes
  has_many :votes, as: :votable
  
  def up_votes
    votes.where(vote: :up)
  end

  def down_votes
    votes.where(vote: :down)
  end

  def raiting
    self.up_votes.count - self.down_votes.count
  end
end
