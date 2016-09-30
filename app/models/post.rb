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

  has_many :likes, as: :likable
  # has_many :likes

  # like the post
  # def like(user)
  #   likes << Like.create(user_id: user.id, likable_id: self.id, likable_type: self.class)
  # end

  # unlike the post
  # def unlike(user)
  #   likes.where(user_id: user.id).first.destroy
  # end

  # if current_user liked post
  def liked?(user)
    !(likes.where(user_id: user.id).empty?)
  end

  # def liked?(user)
  #   likes.include? user.id
  # end

  # def like(user)
  #   likes << user.id
  # end

  # def like!(user)
  #   like(user)
  #   save
  # end

  # def unlike(user)
  #   likes.delete(user.id)
  # end

  # def unlike!(user)
  #   unlike(user)
  #   save
  # end

end
