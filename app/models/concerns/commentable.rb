module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable, dependent: :destroy
  end

  def commented_by(commentator, comment)
    comments.build(user_id: commentator.id, body: comment)
    save
  end

  def comments_count
    comments.count
  end
end
