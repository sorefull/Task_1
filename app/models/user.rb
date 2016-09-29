# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  role            :integer          default("user")
#  status          :integer          default("normal")
#  feed            :text
#

class User < ApplicationRecord
  # Registration autorization
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
  has_secure_password
  # validates :password, presence: true, length: { minimum: 6 }

  # Posts
  has_many :posts

  #admin
  enum role: [:user, :admin] #[:moderator, :owner, etc]

  # blocked
  enum status: [:normal, :blocked]

  # folowing
  serialize :feed, Array

  def subscribe!(user)
    unless self.feed.include? user.id
      self.feed << user.id
      self.save
      true
    else
      false
    end
  end

  def subscribers
    User.find(self.feed)
  end

  def unsubscribe!(user)
    if self.feed.include? user.id
      self.feed.delete user.id
      self.save
      true
    else
      false
    end
  end

  def destroy_user
    User.all.each do |e_user|
      e_user.unsubscribe! self
    end
    self.destroy
  end

end
