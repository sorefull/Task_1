# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  likes      :text
#

class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :body, presence: true, length: { maximum: 140 }

  # likes
  serialize :likes, Array

  def liked_by!(user)
    unless self.likes.include? user.id
      self.likes << user.id
      self.save
      true
    else
      false
    end
  end

  def liked_by
    User.find(self.likes)
  end

  def unliked_by!(user)
    if self.likes.include? user.id
      self.likes.delete user.id
      self.save
      true
    else
      false
    end
  end

end
